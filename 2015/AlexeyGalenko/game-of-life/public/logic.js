var Life = {};
Life.nRow = 10; // Число строк в матрице
Life.nCol = 10; // Число столбцов в матрице
Life.numbercells = Life.nRow*Life.nCol;
Life.lifeCell = "#f00"; // Цвет живой клетки

Life.putM = function() //Построить пустую матрицу
{
var str = "<TABLE id='mLife' cellspacing=0 cellpadding=0>";
for(var i=0; i<Life.nRow; i++)
{
str += "<TR>";
for(var j=0; j<Life.nCol; j++)
str += "<TD id='"+Life.getId(i,j)+"'>&nbsp;</TD>";
str += "</TR>";
}
str += "</TABLE>";
document.write(str);
};

Life.BringLifeCells = function() //Нанести случайным образом живые клетки
{
var random = Life.random ();
for(var i=0; i<random.length; i++)
{
	var k = parseInt(random[i]/Life.nRow);
	var j = random[i]%Life.nRow;
	Life.changeCellStatus(k, j);
}
};

Life.changeCellStatus = function(row, col) 
{
var id = Life.getId(row, col);
var st = document.getElementById(id).style;
st.backgroundColor = Life.lifeCell; // установить фон
};

Life.getId = function(row, col)
{
return "c"+row+"_"+col;
};

Life.random = function() //возвращает массив случайной длины случайных чисел
{
var NumberLifeCells = Math.floor(Math.random()*Life.numbercells);
var numbers = [];
for(var i=0; i<Life.numbercells; i++)
{
	numbers[i] = i;
}
var n = shuffle(numbers);
n.length = NumberLifeCells;
return n;
};

function shuffle(o)
{
for(var j, x, i = o.length; i; j = parseInt(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
return o;
};
