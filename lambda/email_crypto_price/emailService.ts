import { SES } from 'aws-sdk';
import { currency } from "./constants";

const ses = new SES({ region: 'us-east-2' });

export const SendPriceEmail = async (SES_EMAIL: string, toEmail: string, coin: string, price: string): Promise<void> => {
    await ses.sendEmail({
        Source: SES_EMAIL,
        Destination: { ToAddresses: [toEmail] },
        Message: {
            Subject: { Data: `Price of ${coin}` },
            Body: {
                Text: { Data: `Current price of ${coin} is ${price} ${currency}.` },
            },
        },
    }).promise();

    return;
}