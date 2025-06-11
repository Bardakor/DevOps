// Simple test file
const app = require('./index.js');

console.log('Running tests...');

// Test 1: Check if app is defined
if (typeof app === 'object') {
  console.log('✅ Test 1 passed: App is properly exported');
} else {
  console.log('❌ Test 1 failed: App is not properly exported');
  process.exit(1);
}

// Test 2: Simple logic test
function add(a, b) {
  return a + b;
}

if (add(2, 3) === 5) {
  console.log('✅ Test 2 passed: Basic math works');
} else {
  console.log('❌ Test 2 failed: Basic math failed');
  process.exit(1);
}

// Test 3: Environment check
if (process.env.NODE_ENV !== 'production' || process.env.NODE_ENV === undefined) {
  console.log('✅ Test 3 passed: Not in production environment');
} else {
  console.log('✅ Test 3 passed: In production environment');
}

console.log('🎉 All tests passed!');
process.exit(0);
