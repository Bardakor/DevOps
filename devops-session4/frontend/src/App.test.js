import { render, screen } from '@testing-library/react';
import App from './App';

// Mock fetch
global.fetch = jest.fn();

describe('App Component Tests', () => {
  beforeEach(() => {
    fetch.mockClear();
  });

  test('renders DevOps CI/CD Pipeline Demo heading', () => {
    fetch.mockResolvedValueOnce({
      json: async () => ({ message: 'Backend is running successfully!' }),
    });

    render(<App />);
    const linkElement = screen.getByText(/DevOps CI\/CD Pipeline Demo/i);
    expect(linkElement).toBeInTheDocument();
  });

  test('displays loading state initially', () => {
    fetch.mockImplementation(() => new Promise(() => {})); // Never resolves

    render(<App />);
    const loadingElement = screen.getByText(/Loading.../i);
    expect(loadingElement).toBeInTheDocument();
  });

  test('displays success message when fetch succeeds', async () => {
    fetch.mockResolvedValueOnce({
      json: async () => ({ message: 'Backend is running successfully!' }),
    });

    render(<App />);
    
    // Wait for the component to update
    await screen.findByText(/Frontend and Backend are running successfully!/i);
    
    expect(screen.getByText(/Frontend and Backend are running successfully!/i)).toBeInTheDocument();
  });
}); 