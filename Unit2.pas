unit Unit2;

interface

type
  vector = array [1..3] of real;
  projection = array [1..2] of vector;

Procedure NormLine(x0,y0,x1,y1,color: integer);
Procedure CDP(alpha: real; var P: Projection);
Procedure Project(const P: Projection; const x,y,z: real; const u0,v0: integer; var u,v: integer);
Procedure DrawSurf;
Procedure FindCoord(var x,y: real; var xp,yp: integer);
Function  Fun(x,y: real):real;

implementation
uses Unit1, Graphics;

Procedure NormLine(x0,y0,x1,y1,color: integer);
begin
b.Canvas.Pen.Color:=color;
b.Canvas.MoveTo(sx+x0,sy-y0);
b.Canvas.LineTo(sx+x1,sy-y1);
end;

Procedure CDP(alpha: real; var P: Projection);
var t: real;
begin
alpha:= pi*alpha/180.0;
P[1,1]:=-1.0/sqrt(2.0);
P[1,2]:=-P[1,1];
P[1,3]:=0.0;
t:=sin(alpha)/cos(alpha);
P[2,1]:=t*P[1,1];
P[2,2]:=P[2,1];
P[2,3]:=sqrt(1.0-sqr(t));
end;

Procedure Project(const P: Projection; const x,y,z: real; const u0,v0: integer; var u,v: integer);
begin
u:= u0+round(P[1,1]*x+P[1,2]*y+P[1,3]*z);
v:= v0+round(P[2,1]*x+P[2,2]*y+P[2,3]*z);
end;

Function Fun(x,y: real):real;
begin
Fun:=sin(x/2+a);
end;

Procedure FindCoord(var x,y: real; var xp,yp: integer);
begin
z:= 10*Fun(0.1*x,0.1*y);
project(P,x,y,z,0,0,xnew,ynew);
end;

Procedure DrawSurf;
var i,j: integer;
begin
for i:= 0 to 100 do
  begin
  x:=-300+i*6;
  y:=-300;
  FindCoord(x,y,xnew,ynew);
  xold:=xnew;
  yold:=ynew;
  for j:= 1 to 100 do
    begin
    y:=-300+j*6;
    FindCoord(x,y,xnew,ynew);
    NormLine(xnew,ynew,xold,yold,bitmap[Round(x)+300,Round(y)+300]);
    xold:=xnew;
    yold:=ynew;
    end;
  end;
for i:= 0 to 100 do
  begin
  y:=-300+i*6;
  x:=-300;
  FindCoord(x,y,xnew,ynew);
  xold:=xnew;
  yold:=ynew;
  for j:= 1 to 100 do
    begin
    x:=-300+j*6;
    FindCoord(x,y,xnew,ynew);
    NormLine(xnew,ynew,xold,yold,bitmap[Round(x)+300,Round(y)+300]);
    xold:=xnew;
    yold:=ynew;
    end;
end;
end;

end.
 