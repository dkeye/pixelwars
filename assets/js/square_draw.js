import {sendPixel} from "./socket.js"

const drawingCanvas = document.getElementById('wars');
const pixelSize = 8;
const field = initField();
const colorField = document.getElementById('color');

function initField() {
    let array = [];
    for (let Y = 0; Y <= drawingCanvas.height / pixelSize; Y++) {
        array[Y] = [];
        for (let X = 0; X <= drawingCanvas.width / pixelSize; X++) {
            array[Y].push(new Rect(X, Y));
        }
    }
    return array;
}

function Rect(x, y) {
    this.x = x * pixelSize; // координата х
    this.y = y * pixelSize; // координата у
    // функция рисует прямоугольник согласно заданным параметрам
    this.draw = function (context, color) {
        context.fillStyle = color;
        // context.strokeStyle = color;
        context.fillRect(this.x, this.y, pixelSize, pixelSize);
        // context.strokeRect(this.x, this.y, pixelSize, pixelSize);
    };
}

drawingCanvas.addEventListener("mousedown", function (e) {
    let [x, y] = getMousePosition(drawingCanvas, e);
    sendPixel([x, y, colorField.value].join(";"));
    drawPixel([x, y]);
});

function getMousePosition(canvas, event) {
    let rect = canvas.getBoundingClientRect();
    let x = Math.floor((event.clientX - rect.left) / pixelSize);
    let y = Math.floor((event.clientY - rect.top) / pixelSize);
    return [Math.round(x), Math.round(y)];
}

export function enteredPixel(body) {
    let [x, y, color] = body.split(';');
    console.log("incoming", x, y, color)
    drawPixel([Number(x), Number(y)], color);
}

export function fillBoard(body) {
    for (let i = 0; i < body.length; i++) {
        let [x, y, color] = body[i].split(";");
        console.log("fill", x, y, color)
        drawPixel([x, y], color);
    }
}

function drawPixel([x, y], color = colorField.value) {
    let context = drawingCanvas.getContext('2d');
    field[y][x].draw(context, color);
}
