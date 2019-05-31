<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>샘플</title>
<!-- TOAST UI 적용  2019.01.03 CDN 적용 Start -->
<link rel="stylesheet" type="text/css" href="css/tui-example-style.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
</head>
<body>
    <div id="grid"></div>
</body>

<!-- TOAST UI 적용  2019.01.03 CDN 적용 End -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/backbone.js/1.3.3/backbone.js"></script>
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/v1.5.0/tui-code-snippet.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<!-- <script type="text/javascript" src="data/basic-dummy.js"></script> -->
 <script type="text/javascript">

  var grid = new tui.Grid({
      el: $('#grid'),
      scrollX: false,
      scrollY: false,
      columns: [
          {
              title: 'Name',
              name: 'name',
              onBeforeChange: function(ev){
                  console.log('Before change:' + ev);
              },
              onAfterChange: function(ev){
                  console.log('After change:' + ev);
              },
              editOptions: {
                  type: 'text',
                  useViewMode: true
              }
          },
          {
              title: 'Artist',
              name: 'artist',
              onBeforeChange: function(ev){
                  console.log('Before change:' + ev);
                  ev.stop();
              },
              onAfterChange: function(ev){
                  console.log('After change:' + ev);
              },
              editOptions: {
                  type: 'text',
                  maxLength: 10,
                  useViewMode: false
              }
          },
          {
              title: 'Type',
              name: 'typeCode',
              onBeforeChange: function(ev){
                  console.log('Before change:' + ev);
              },
              onAfterChange: function(ev){
                  console.log('After change:' + ev);
              },
              editOptions: {
                  type: 'select',
                  listItems: [
                      { text: 'Deluxe', value: '1' },
                      { text: 'EP', value: '2' },
                      { text: 'Single', value: '3' }
                  ],
                  useViewMode: true
              }
          },
          {
              title: 'Genre',
              name: 'genreCode',
              onBeforeChange: function(ev){
                  console.log('Before change:' + ev);
              },
              onAfterChange: function(ev){
                  console.log('After change:' + ev);
              },
              editOptions: {
                  type: 'checkbox',
                  listItems: [
                      { text: 'Pop', value: '1' },
                      { text: 'Rock', value: '2' },
                      { text: 'R&B', value: '3' },
                      { text: 'Electronic', value: '4' },
                      { text: 'etc.', value: '5' }
                  ],
                  useViewMode: true
              },
              copyOptions: {
                  useListItemText: true // when this option is used, the copy value is concatenated text
              }
          },
          {
              title: 'Grade',
              name: 'grade',
              onBeforeChange: function(ev){
                  console.log('Before change:' + ev);
              },
              onAfterChange: function(ev){
                  console.log('After change:' + ev);
              },
              copyOptions: {
                  useListItemText: true
              },
              editOptions: {
                  type: 'radio',
                  listItems: [
                      { text: '★☆☆☆☆', value: '1' },
                      { text: '★★☆☆☆', value: '2' },
                      { text: '★★★☆☆', value: '3' },
                      { text: '★★★★☆', value: '4' },
                      { text: '★★★★★', value: '5' }
                  ],
                  useViewMode: true
              }
          }
      ]
  });
  //gridData :json 형태 값  
  grid.setData(gridData);
  </script>

</html>