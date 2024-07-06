import axios from 'axios';
import { currency } from './constants';

export interface CoinDataResponse {
    [key: string]: {
        [currencyCode: string]: string;
    };
}

export const FetchCoinData = async (coin: string): Promise<CoinDataResponse> => {
    const response = await axios.get(`https://api.coingecko.com/api/v3/simple/price?ids=${coin}&vs_currencies=${currency}`);
    return response.data;
}