import React, { createContext, useContext, useState } from 'react';

const CursorContext = createContext({
  cursorText: '',
  cursorVariant: 'default',
  setCursorText: () => {},
  setCursorVariant: () => {},
  resetCursor: () => {},
});

export const CursorProvider = ({ children }) => {
  const [cursorText, setCursorText] = useState('');
  const [cursorVariant, setCursorVariant] = useState('default');

  const resetCursor = () => {
    setCursorText('');
    setCursorVariant('default');
  };

  return (
    <CursorContext.Provider
      value={{
        cursorText,
        cursorVariant,
        setCursorText,
        setCursorVariant,
        resetCursor,
      }}
    >
      {children}
    </CursorContext.Provider>
  );
};

export const useCursor = () => useContext(CursorContext);
