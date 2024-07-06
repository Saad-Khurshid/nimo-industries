import { DynamoDB } from 'aws-sdk';

const dynamoDb = new DynamoDB.DocumentClient();

export const ReadHistoryToDynamoDB = async (TABLE_NAME: string, exclusiveStartKey: DynamoDB.DocumentClient.Key, email: string): Promise<DynamoDB.DocumentClient.QueryOutput> => {
    const params: DynamoDB.DocumentClient.QueryInput = {
        TableName: TABLE_NAME || '',
        KeyConditionExpression: 'email = :email',
        ExpressionAttributeValues: {
            ':email': email
        },
        Limit: 10,
        ExclusiveStartKey: exclusiveStartKey,
        ScanIndexForward: false
    };

    const data = await dynamoDb.query(params).promise();
    return data;
}