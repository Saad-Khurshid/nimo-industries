import { APIGatewayProxyHandler } from 'aws-lambda';
import axios from 'axios';
import { CoinDataResponse, FetchCoinData } from './apiService';
import { SendPriceEmail } from './emailService';
import { IsValidEmail } from './validations';
import { currency } from './constants';
import { WriteHistoryToDynamoDB } from './dynamoDbService';


const { TABLE_NAME, SES_EMAIL } = process.env

export const handler: APIGatewayProxyHandler = async (event: any) => {
    try {
        if (!TABLE_NAME || !SES_EMAIL) {
            throw new Error('Missing environment variables');
        }

        const { coin, toEmail } = event.queryStringParameters;

        if (!coin || !toEmail) {
            return { statusCode: 400, body: 'Missing coin or toEmail query parameter' };
        }

        if (!IsValidEmail(toEmail)) {
            return { statusCode: 400, body: 'Invalid email format' };
        }

        const coinData: CoinDataResponse = await FetchCoinData(coin);
        if (!coinData || !coinData[coin] || !coinData[coin][currency]) {
            return { statusCode: 400, body: 'Coin data not found' };
        }
        const price = coinData[coin][currency];

        await WriteHistoryToDynamoDB(TABLE_NAME, toEmail, coin, price);

        await SendPriceEmail(SES_EMAIL, toEmail, coin, price);

        return { statusCode: 200, body: 'Coin data sent successfully' };
    } catch (error) {
        let errorMessage = 'Internal Server Error';
        if (axios.isAxiosError(error)) {
            errorMessage = `Failed to fetch coin data: ${error.message}`;
        } else if (error instanceof Error) {
            errorMessage = `Error: ${error.message}`;
        }
        return { statusCode: 500, body: errorMessage };
    }
};