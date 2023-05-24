import React from 'react';
import { useState } from "react";
import { options, currencies_to_convert_in_header, banknote_emojis } from '../global';

export default function Header() {
    const [currencies, setHeaderCurrencies] = useState([]); // variable for loading currencies in it
    const [is_loaded, setLoaded] = useState(false); // variable for checking if data was fetched for preventing doing it again

    // getting currencies from API
    const getCurrencies = async () => {
        if (!is_loaded) {
            currencies_to_convert_in_header.map(async (currency) => {
                const response = await fetch(
                    `https://exchangerate-api.p.rapidapi.com/rapid/latest/${currency}`, options
                ).then((response) => response.json());

                setHeaderCurrencies((existingItems) => {
                    return existingItems.concat([{
                        name: currency,
                        rates: response.rates
                    }]);
                })
            })
            setLoaded(true);
        }
    };

    React.useEffect(() => {
        getCurrencies();
    });

    return (
        <header className="Header">
            <div className="header_text">
                <p>Online currency converter</p>
            </div>

            <div className="header_currencies">
                {
                    currencies?.map((currency, i) => {
                        return (
                            <div key={i} className="header_currency">
                                <p>
                                    {currency?.name} {banknote_emojis[i]} {currency?.rates?.UAH}
                                </p>
                            </div>
                        )
                    })
                }
            </div>
        </header>
    );
}
