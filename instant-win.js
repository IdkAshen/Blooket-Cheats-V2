// Create a button to win instantly
const winInstantlyButton = document.createElement('button');
winInstantlyButton.textContent = 'Win Instantly!';
winInstantlyButton.addEventListener('click', winInstantly);

// Add the button to the page
document.body.appendChild(winInstantlyButton);

// Function to win instantly
function winInstantly() {
  // Simulate pressing the 'Win Instantly!' button
  const interval = setInterval(() => {
    winInstantlyButton.click();
  }, 100);
}

async
