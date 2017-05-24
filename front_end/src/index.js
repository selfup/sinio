const pageData = document.querySelector('#app').dataset;

switch (pageData.pageName) {
  case 'home#index':
    System.import('./home');
    break;
  default:
    break;
}
