// Get the current coin count
let currentCoins = 1000;

// Create a button to add coins
const addCoinsButton = document.createElement('button');
addCoinsButton.textContent = 'Add Coins!';
addCoinsButton.addEventListener('click', addCoins);

// Add the button to the page
document.body.appendChild(addCoinsButton);

// Function to add coins
function addCoins() {
  // Increment the current coin count
  currentCoins += 1000;
  // Update the display of the coin count
  document.getElementById('coinCount').textContent = currentCoins;
}
