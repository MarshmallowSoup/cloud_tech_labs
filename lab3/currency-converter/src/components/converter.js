import React from 'react';
import { useState } from "react";
import { options, currencies_to_convert_in_converter, flag_emojis } from '../global';

export default function Converter() {
    const [currencies, setConverterCurrencies] = useState([]);  // variable for loading currencies in it
    const [is_loaded, setLoaded] = useState(false); // variable for checking if data was fetched for preventing doing it again

    const [first_select, setFirstSelect] = useState(0); // current selects
    const [second_select, setSecondSelect] = useState(1);

    const [first_input, setFirstInput] = useState(""); // current inputs
    const [second_input, setSecondInput] = useState("");

    // getting currencies from API
    const getCurrencies = async () => {
        if (!is_loaded) {
            currencies_to_convert_in_converter.map(async (currency) => {
                const response = await fetch(
                    `https://exchangerate-api.p.rapidapi.com/rapid/latest/${currency}`, options
                ).then((response) => response.json());

                setConverterCurrencies((existingItems) => {
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

    // function for converting from first to second curency and multiplying it by provided value in input
    const convertCurrencies = (firts, second, multiplier) => {
        for (var i in currencies) {
            if (currencies[i]?.name === firts) {
                const result = Math.round(((currencies[i]?.rates[second]) * multiplier) * 100) / 100;
                return result;
            }
        }
    }

    // called when option in select have changed, function setting current select variable value and converting other input according to changes
    const onClickOption = (newSelect, select_number) => {
        if (select_number === 1) {
            setFirstSelect(newSelect);
            setSecondInput(convertCurrencies(currencies_to_convert_in_converter[newSelect], currencies_to_convert_in_converter[second_select], first_input));
        }
        else
            if (select_number === 2) {
                setSecondSelect(newSelect);
                setFirstInput(convertCurrencies(currencies_to_convert_in_converter[newSelect], currencies_to_convert_in_converter[first_select], second_input));
            }
    }

    // called when input have changed, function setting current input variable value and converting other input according to changes
    const onChangeInput = (newInput, select_number) => {
        if (select_number === 1) {
            setFirstInput(newInput);
            setSecondInput(convertCurrencies(currencies_to_convert_in_converter[first_select], currencies_to_convert_in_converter[second_select], newInput));
        }
        else
            if (select_number === 2) {
                setSecondInput(newInput);
                setFirstInput(convertCurrencies(currencies_to_convert_in_converter[second_select], currencies_to_convert_in_converter[first_select], newInput));
            }
    }

    return (
        <div className="Converter">
            <div className="converter_text">
                <p>Choose currency and amount, then convert</p>
            </div>

            <div className="converter_action_zone">
                <div>
                    <select className="converter_select" value={first_select} id="first_select" onChange={(event) => onClickOption(event.target.value, 1)}>
                        {
                            currencies_to_convert_in_converter.map((currency, i) => {
                                return (
                                    <option value={i} key={i} defaultChecked={(i === 0)}>
                                        {currency} {flag_emojis[i]}
                                    </option>
                                )
                            })
                        }
                    </select>

                    <input className="convert_input" type="number" id="number" value={first_input} placeholder={0} onChange={e => onChangeInput(e.target.value, 1)} />
                </div>

                <div>
                    <select className="converter_select" value={second_select} id="second_select" onChange={(event) => onClickOption(event.target.value, 2)}>
                        {
                            currencies_to_convert_in_converter.map((currency, i) => {
                                return (
                                    <option value={i} key={i} defaultChecked={(i === 1)} >
                                        {currency} {flag_emojis[i]}
                                    </option>
                                )
                            })
                        }
                    </select>

                    <input className="convert_input" type="number" id="number" value={second_input} placeholder={0} onChange={e => onChangeInput(e.target.value, 2)} />
                </div>
            </div>

        </div>
    );
}
