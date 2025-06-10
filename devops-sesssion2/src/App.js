import React from 'react';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <div className="docker-logo">🐳</div>
        <h1>Multi-Stage Docker Build</h1>
        <p>
          This React app was built using a multi-stage Dockerfile for optimal production deployment.
        </p>
        <div className="features">
          <div className="feature">
            <h3>🚀 Small Image Size</h3>
            <p>~20-30MB final image with Nginx</p>
          </div>
          <div className="feature">
            <h3>🔒 Secure</h3>
            <p>No dev dependencies in production</p>
          </div>
        </div>
        <div className="build-info">
          <p>
            <strong>Build Stage:</strong> Node.js 24.2.0
          </p>
          <p>
            <strong>Production Stage:</strong> Nginx Alpine
          </p>
        </div>
      </header>
    </div>
  );
}

export default App;
