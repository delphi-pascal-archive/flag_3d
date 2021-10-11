unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Unit2;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  b: TBitmap;

  bitmap: array [0..600, 0..600] of TColor;

  sx,sy: integer;                  // use in Unit2
  P: Projection;                   // use in Unit2
  xnew,ynew,xold,yold: integer;    // use in Unit2
  x,y,z,a: real;                   // use in Unit2

  needexit: boolean = true;
  pma: boolean = true;             //plus/minus for var A

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
 x,y: integer;
begin
  b := TBitMap.Create;
  b.pixelformat := pf24bit;
  b.width := Screen.width;
  b.height := Screen.height;
  sx:=Screen.width div 2;
  sy:=Screen.height div 2-30;
  a:=0.01;

  for x:= 0 to 600 do
    for y:= 0 to (600 div 3) do
      bitmap[x,y]:= RGB(255,255,255);
  for x:= 0 to 600 do
    for y:= (600 div 3) to 2 * (600 div 3) do
      bitmap[x,y]:= RGB(0,0,255);
  for x:= 0 to 600 do
    for y:= 2 * (600 div 3) to 600 do
      bitmap[x,y]:= RGB(255,0,0);
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
 while needexit do
  begin
    b.Canvas.Brush.Color:=clBlack;
    b.Canvas.FillRect(Rect(0,0,b.Width,b.Height));
    cdp(30,P);
    drawsurf;
    //if pma then a:=a+0.09 else a:=a-0.09;
    a:=a+0.09;
    //if a>=2.4 then pma:= not pma;
    //if a<=0.01 then pma:= not pma;
    Form1.Canvas.Draw(0,0,b);
    Application.ProcessMessages;
  end;
 Close;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
 b.Free;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 needexit:=not needexit;
end;

end.
 