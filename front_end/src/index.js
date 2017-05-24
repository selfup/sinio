const pageData = document.querySelector('#app').dataset;

switch (pageData.pageName) {
  case 'index-app':
    System.import('./home');
    break;
  default:
    break;
}
