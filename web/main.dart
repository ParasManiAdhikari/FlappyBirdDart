import 'dart:html';

void main() {
  querySelector('#output').text =
      'Hooray, your first barebones Dart app is running!';
  // White
  querySelectorAll('#chess tr:nth-child(3) td:nth-child(n+2)').forEach((td) {
    td.innerHtml = "&#9823;";
  });
  querySelectorAll(
          '#chess tr:nth-child(2) td:nth-child(2), #chess tr:nth-child(2) td:nth-child(9)')
      .forEach((td) {
    td.innerHtml = "&#9820;"; //hatti white
  });
  querySelectorAll(
          '#chess tr:nth-child(2) td:nth-child(3), #chess tr:nth-child(2) td:nth-child(8)')
      .forEach((td) {
    td.innerHtml = "&#9822;"; //horse white
  });
  querySelectorAll(
          '#chess tr:nth-child(2) td:nth-child(4), #chess tr:nth-child(2) td:nth-child(7)')
      .forEach((td) {
    td.innerHtml = "&#9821;"; //chadkey white
  });
  querySelector('#chess tr:nth-child(2) td:nth-child(6)').innerHtml =
      "&#9819;"; // mantri white
  querySelector('#chess tr:nth-child(2) td:nth-child(5)').innerHtml =
      "&#9818;"; //rani white

// Black
  querySelectorAll('#chess tr:nth-child(8) td:nth-child(n+2)').forEach((td) {
    td.innerHtml = "&#9817;"; // pipsa black
  });
  querySelectorAll(
          '#chess tr:nth-child(9) td:nth-child(2), #chess tr:nth-child(9) td:nth-child(9)')
      .forEach((td) {
    td.innerHtml = "&#9814;"; //hatti black
  });
  querySelectorAll(
          '#chess tr:nth-child(9) td:nth-child(3), #chess tr:nth-child(9) td:nth-child(8)')
      .forEach((td) {
    td.innerHtml = "&#9816;"; //horse black
  });
  querySelectorAll(
          '#chess tr:nth-child(9) td:nth-child(4), #chess tr:nth-child(9) td:nth-child(7)')
      .forEach((td) {
    td.innerHtml = "&#9815;";
  });
  querySelector('#chess tr:nth-child(9) td:nth-child(5)').innerHtml = "&#9812;";
  querySelector('#chess tr:nth-child(9) td:nth-child(6)').innerHtml = "&#9813;";
}
