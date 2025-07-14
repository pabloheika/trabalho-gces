import React from 'react';
import { render, screen } from '@testing-library/react';
import Layout from '../../components/Layout';

describe('Layout Component', () => {
  test('renders children correctly', () => {
    const testMessage = 'Test content';
    render(
      <Layout>
        <div>{testMessage}</div>
      </Layout>
    );
    
    expect(screen.getByText(testMessage)).toBeInTheDocument();
  });

  test('renders navigation', () => {
    render(
      <Layout>
        <div>Test content</div>
      </Layout>
    );
    
    // Verifica se o componente Nav está presente
    expect(document.querySelector('nav')).toBeInTheDocument();
  });
}); 