const message = () => {
  const ajax = document.querySelector('.ajax')
  fetch('/random', { headers: { accept: "application/json" }})
      .then(response => response.json())
      .then((data) => {
        console.log(data);
        ajax.innerText = data;
      });
}

const reload = () => {
  const button = document.querySelector('.button')
  button.addEventListener('click', event => {
    event.preventDefault;
    message();
  });
}

export { reload };
export { message };
