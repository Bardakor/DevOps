const request = require('supertest');
const app = require('../server');

describe('Backend API Tests', () => {
  test('GET /api/health should return success', async () => {
    const response = await request(app)
      .get('/api/health')
      .expect(200);
    
    expect(response.body).toHaveProperty('message');
    expect(response.body).toHaveProperty('timestamp');
    expect(response.body.message).toBe('Backend is running successfully!');
  });

  test('GET /api/status should return status information', async () => {
    const response = await request(app)
      .get('/api/status')
      .expect(200);
    
    expect(response.body).toHaveProperty('status', 'OK');
    expect(response.body).toHaveProperty('service', 'DevOps CI/CD Backend');
  });

  test('GET /api/data should return data array', async () => {
    const response = await request(app)
      .get('/api/data')
      .expect(200);
    
    expect(response.body).toHaveProperty('data');
    expect(Array.isArray(response.body.data)).toBe(true);
    expect(response.body.data).toHaveLength(3);
  });

  test('GET /nonexistent should return 404', async () => {
    const response = await request(app)
      .get('/nonexistent')
      .expect(404);
    
    expect(response.body).toHaveProperty('error', 'Route not found');
  });
}); 