import React from 'react';
import './App.css';
import Header from './components/header';
import Converter from './components/converter';

export default function App() {
  return (
    <div className="App">
      <Header />
      <Converter />
    </div>
  );
}

