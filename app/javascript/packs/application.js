// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
var datos = {
  token: document.getElementsByName('csrf-token')[0].content,
  pagination: "flickr_pagination",
  select_baby: null,
  select_assistant: null,
  select_activity: null,
  select_status: null,
  btn_reset:null,
  btn_search:null,
  baby_value: 0,
  assistant_value: 0,
  activity_value: 0,
  status_value: 0,
  status: 500,
  rows: [],
  response: {}
}
var actions = {
  initAllElements(){
    datos.select_baby =  document.getElementById("baby_id");
    datos.select_assistant =  document.getElementById("assistant_id");
    datos.select_activity =  document.getElementById("activity_id");
    datos.select_status =  document.getElementById("status");
    datos.btn_reset = document.getElementById("reset");
    datos.btn_search = document.getElementById("search");
  },
  displayPagination(show){
    datos.pagination.style.display = show ? "block" : "none"
  },
  initOnChanges(){
    datos.pagination = document.getElementsByClassName("flickr_pagination")[0];
    datos.select_baby.addEventListener("change",()=>{
      let array = datos.select_baby;
      var value = actions.getOptionValue(array.options,array.selectedIndex)
      actions.set_baby(value);
    })
    datos.select_assistant.addEventListener("change",()=>{
      let array = datos.select_assistant;
      var value = actions.getOptionValue(array.options,array.selectedIndex)
      actions.set_assistant(value);
    })
    datos.select_activity.addEventListener("change",()=>{
      let array = datos.select_activity;
      var value = actions.getOptionValue(array.options,array.selectedIndex)
      actions.set_activity(value);
    })
    datos.select_status.addEventListener("change",()=>{
      let array = datos.select_status;
      var value = actions.getOptionValue(array.options,array.selectedIndex)
      actions.set_status(value);
    })
    datos.btn_reset.addEventListener("click",()=>{
      actions.resetSelects()
      actions.destroyRows();
      document.getElementById("rows").innerHTML = datos.rows;
      actions.displayPagination(true);
    });
    datos.btn_search.addEventListener("click",()=>{
      actions.displayPagination(false);
      actions.send_search();
    });
  },
  resetSelects(){
    actions.set_baby(null);
    actions.set_assistant(null);
    actions.set_activity(null);
    actions.set_status(null);
    datos.select_baby.selectedIndex = 0
    datos.select_assistant.selectedIndex = 0
    datos.select_activity.selectedIndex = 0
    datos.select_status.selectedIndex = 0
  },
  delateRow(i) {
    document.getElementById("rows").deleteRow(i);
  },
  formatTime(time){
    var dateTime = new Date(time);
    return moment(dateTime).format("YYYY-MM-DD HH:mm:ss");
  },
  calcule_status(value){
    return value == "in_progress" ? "En progreso" : "Terminada";
  },
  addRows(i,item) {
    var table = document.getElementById("rows");
    var row = table.insertRow(i);
    actions.build_row(row,item.baby_name,0)
    actions.build_row(row,item.assistant_name, 1)
    actions.build_row(row,item.activity_name, 2)
    actions.build_row(row,actions.formatTime(item.start_time), 3)
    actions.build_row(row,actions.calcule_status(item.status), 4)
    actions.build_row(row,`${item.duration} min.`, 5)
  },
  build_row(row,value,i){
    var cell = row.insertCell(i);    
    cell.innerHTML = value
  },
  createRows(){
    for (let index = 0; index < datos.response.length; index++) {
      const element = datos.response[index];
      actions.addRows(index,element); 
    }
  },
  destroyRows(){
    let rows = document.getElementById("rows").childElementCount;
    for (let index = rows -1 ; index >= 0; index--) {      
      actions.delateRow(index);
    }
  },
  setRows(){
    datos.rows = document.getElementById("rows").innerHTML
  },
  find_value(value){
    return value != "" ? value : null;
  },
  set_baby(value){
    datos.baby_value = this.find_value(value); 
  },
  set_assistant(value){
    datos.assistant_value = this.find_value(value); 
  },
  set_activity(value){
    datos.activity_value = this.find_value(value); 
  },
  set_status(value){
    datos.status_value = this.find_value(value); 
  },
  create_array_search(){
    var searches = []
    if(datos.baby_value ){
      searches.push({baby_id:datos.baby_value})
    }
    if(datos.assistant_value ){
      searches.push({assistant_id:datos.assistant_value})
    }
    if(datos.activity_value ){
      searches.push({activity_id:datos.activity_value})
    }
    if(datos.status_value ){
      searches.push({status:datos.status_value})
    }
    return searches
  },
  create_params(){
    let searches = actions.create_array_search();
    var query = "";
    for (let index = 0; index < searches.length; index++) {
      query = index == 0 ? `${query}?` : query;
      const element = searches[index];
      var key = Object.keys(element)[0];
      var temporal_query =`${key}=${element[key]}`
      if ((1 + index) < searches.length){
        temporal_query = `${temporal_query}&`
      }
      query = `${query}${temporal_query}`
    }
    return query;
  },
  getOptionValue(options,selectedIndex){
    return options[selectedIndex].value
  },
  send_search(){
    if (actions.create_array_search().length == 0){
      alert("Seleccione minimo un campo");
      return
    }
    var url = `/activity_logs${actions.create_params()}`
    fetch(url,
      {
        method: 'GET',
        headers: {           
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        }
      }
    )
    .then( response => {
      datos.status = response.clone().status
      return response.json()
    })
    .then( response => {
      datos.response = response 
      if(datos.status == 200){
        actions.destroyRows();
        actions.createRows();
      } else {
        alert(datos.status)
      }
    })
    .catch(console.log)
  }
}
window.onload = ()=>{
  actions.initAllElements()
  actions.initOnChanges()
  actions.setRows()
}