export const IsValidEmail = (email: string): boolean => {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
};

// open for discussion
// we can add validation for the coin parameter if we compile list of all coins
const popularCoins = ['bitcoin', 'ethereum', 'tether', 'bnb', 'usdc', 'ripple', 'litecoin', 'cardano', 'binance coin', 'polkadot', 'solana'];
export const ValidateCoin = (coin: string): boolean => {
    return popularCoins.includes(coin.toLowerCase());
}