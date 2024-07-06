import { DynamoDB } from 'aws-sdk';
import { currency } from "./constants";

const dynamoDb = new DynamoDB.DocumentClient();

export const WriteHistoryToDynamoDB = async (TABLE_NAME: string, toEmail: string, coin: string, price: string): Promise<void> => {
    const timestamp = Math.floor(Date.now() / 1000);

    await dynamoDb.put({
        TableName: TABLE_NAME,
        Item: {
            email: toEmail,
            timestamp,
            coin,
            currency,
            price,
        },
    }).promise();

    return;
}