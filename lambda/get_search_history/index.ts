import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import { ReadHistoryToDynamoDB } from './dynamoDbService';


const TABLE_NAME = process.env.TABLE_NAME;

export const handler = async (event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult> => {
    try {
        const email = event.queryStringParameters?.email;
        const exclusiveStartKey = event.queryStringParameters?.exclusiveStartKey ? JSON.parse(decodeURIComponent(event.queryStringParameters.exclusiveStartKey)) : undefined;

        if (!TABLE_NAME) {
            throw new Error('Missing environment variables');
        }

        if (!email) {
            return {
                statusCode: 400,
                body: JSON.stringify({ error: 'Email parameter is required.' })
            };
        }

        const data = await ReadHistoryToDynamoDB(TABLE_NAME, exclusiveStartKey, email);

        const response = {
            items: data.Items,
            count: data.Count,
            lastEvaluatedKey: data.LastEvaluatedKey ? encodeURIComponent(JSON.stringify(data.LastEvaluatedKey)) : null
        };

        return {
            statusCode: 200,
            body: JSON.stringify(response)
        };
    } catch (err) {
        return {
            statusCode: 500,
            body: JSON.stringify({ error: 'Failed to fetch search history.' })
        };
    }
};