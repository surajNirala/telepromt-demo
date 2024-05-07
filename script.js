const teleprompter = document.getElementById('teleprompter');
const words = teleprompter.innerText.split(' ');

let currentIndex = 0;

function updateText() {
  let text = '';
  let highlightedWordIndex = currentIndex % words.length;
  for (let i = currentIndex; i < currentIndex + 5; i++) {
    text += words[i % words.length] + ' ';
  }
  teleprompter.innerHTML = text;
  document.getElementById('highlight').textContent = words[highlightedWordIndex];
  currentIndex += 1;
}

updateText();
setInterval(updateText, 5000); // Change every 5 seconds
