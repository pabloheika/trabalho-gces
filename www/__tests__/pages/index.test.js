import React from 'react';
import { render, screen } from '@testing-library/react';
import Home from '../../pages/index';

// Mock do Next.js router
jest.mock('next/router', () => ({
  useRouter() {
    return {
      route: '/',
      pathname: '/',
      query: {},
      asPath: '/',
    };
  },
}));

describe('Home Page', () => {
  test('renders welcome message', () => {
    render(<Home />);
    
    // Verifica se há algum texto de boas-vindas
    expect(screen.getByText(/welcome/i)).toBeInTheDocument();
  });

  test('renders navigation links', () => {
    render(<Home />);
    
    // Verifica se há links de navegação
    const links = screen.getAllByRole('link');
    expect(links.length).toBeGreaterThan(0);
  });
}); 