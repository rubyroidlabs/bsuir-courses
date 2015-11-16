$(document).ready(function(){

  $('button').mouseenter(function(){
    $(this).css("font-size","32px");
  });

  $('button').mouseleave(function(){
      $(this).css("font-size","20px");
  });

  var step = 0;
  var size_x = 10;
  var size_y = 10;
  var flag_field = 0;
  var cells_array = [];
  var living_cells = [];
  var state_field = [];
  var my_green = 'rgb(0, 255, 0)';
  var IntervalID;

  function CreateField(size_y,size_x){
    var size_cell = 200/size_x + 'px'
    var newElem=document.createElement("table");
    for(var i=0; i<size_y; i++){
      cells_array[i]=[];
      living_cells[i]=[];
      state_field[i]=[];
      newRow = newElem.insertRow();
      for(var j=0; j<size_x; j++){
        cells_array[i][j] = newRow.insertCell(j);
        living_cells[i][j] = 0;
        state_field[i][j] = 0;
      }
      cells_array[i][size_x-1] = newElem.insertRow();
    }
    
    for(var i=0; i<size_y; i++)
      for(var j=0; j<size_x; j++)
        $("#govo").append(cells_array[i][j]);
    $('td').css('padding',size_cell);

    TableClick();
  }

  function TableClick() {
     $('td').click(function(){
        if(ColorGreen(this))
          ToBlack(this);
        else
          ToGreen(this);
      });
  }

  function ColorGreen(element){
    if($(element).css('background-color') == my_green)
      return true;
    return false;
  }

  function ToGreen(element){
    $(element).css('background-color', my_green);
  }

  function ToBlack(element){
    $(element).css('background-color', 'black');
  }

  function FieldRandom(){
    $("td").each(function(index, element){
      if(Math.random() < 0.2)
        ToGreen(element);
      else ToBlack(element);
    });
  }

  function Inversion(){
    for (var i = 0; i < size_y; i++)
      for (var j = 0; j < size_x; j++){
        if(ColorGreen(cells_array[i][j]))
          ToBlack(cells_array[i][j]);
        else
          ToGreen(cells_array[i][j]);
      }
  }

  function ChangeSize(){
    $('td').remove();
    CreateField(size_y,size_x);
  }
  
  function GetStateField(){
    for (var i = 0; i < size_y; i++)
      for (var j = 0; j < size_x; j++) {
        if ( ColorGreen(cells_array[i][j]) )
          state_field[i][j] = 1;
        else
          state_field[i][j] = 0;
      }
  }

  function ResetLivingCells(){
    for(var i=0; i<size_y; i++){
      living_cells[i]=[];
      for(var j=0; j<size_x; j++)
        living_cells[i][j] = 0;
    }
  }

  function NearbyCells(y, x){
    var count = 0;
    var x_end = x + 2;
    var y_end = y + 2;
    var x_start = x - 1;
    var y_start = y - 1;
    if(y == 0)
      y_start = y;
    if(x == 0)
      x_start = x;
    if(y == size_y-1)
      y_end = y + 1;
    if(x == size_x-1)
      x_end = x + 1;

    for(var i =y_start; i<y_end; i++)
      for(var j=x_start;j<x_end; j++)
        if(state_field[i][j])
          count++;
    return count;
  }

  function NextStep(){
    for (var i = 0; i < size_y; i++)
      for (var j = 0; j < size_x; j++) {
        var nearby_cells = NearbyCells(i,j);
        if (ColorGreen(cells_array[i][j]))
          if (nearby_cells-1 == 2 || nearby_cells-1 == 3)
            living_cells[i][j] = 1;
          if (!ColorGreen(cells_array[i][j]))
            if (nearby_cells == 3)
              living_cells[i][j] = 1;
      }
  }

  function GenerateNextStep(){
    flag_field = 0;
    ResetLivingCells();
    GetStateField();
    NextStep();
    GenerateNextField();
    if(flag_field == 1)
      document.getElementById("step").value = ++step; 
  }

  function GenerateNextField(){
     for (var i = 0; i < size_y; i++)
      for (var j = 0; j < size_x; j++) {
        if(living_cells[i][j]){
          ToGreen(cells_array[i][j]);
          flag_field = 1;
        }
        else
          ToBlack(cells_array[i][j]);
      }
  }

  function ResetCountStep(){
    step = 0;
    document.getElementById("step").value = step;
  }

  $("#btnStart").click(function(){
    IntervalID = setInterval(GenerateNextStep , 200);
   });

  $("#btnNextStep").click(function(){
     GenerateNextStep();
     });

  $("#btnStop").click(function(){
    clearInterval(IntervalID);
  });

  $("#btnSize").click(function(){
      size_x = document.getElementById("sizeX").value
      size_y = document.getElementById("sizeY").value 
      ChangeSize();
  });

  $("#btnRandom").click(function(){ 
    ResetCountStep();
    ToBlack('td');
    FieldRandom();
  });

  $("#btnInversion").click(function(){
     Inversion();
     ResetCountStep();
  });

  $("#btnClear").click(function(){
    ToBlack('td');
    ResetCountStep();
  });

  CreateField(10,10);
});

