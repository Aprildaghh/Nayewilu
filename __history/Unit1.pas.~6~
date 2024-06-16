unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TNayewilu = class(TForm)
    addBtn: TButton;
    rightBtn: TButton;
    leftBtn: TButton;
    appLabel: TLabel;
    openBtn: TButton;
    searchBox: TEdit;
    searchBtn: TButton;
    imageBox: TImage;
    procedure FormCreate(Sender: TObject);
    procedure rightBtnClick(Sender: TObject);
    procedure leftBtnClick(Sender: TObject);
    procedure searchBtnClick(Sender: TObject);
  private
    { Private declarations }
    
  public
    { Public declarations }
  end;

var
  Nayewilu: TNayewilu;
  currentIndex, maxIndex : integer;
  allApplicationArray, currentApplicationArray : array[0 .. 150] of string;

implementation

{$R *.dfm}

procedure addApplication(newApp : string);
begin

end;

procedure readApplicationList;
begin

end;

procedure showApplication(index : integer = 0);
begin
  currentIndex := index;
end;

procedure TNayewilu.FormCreate(Sender: TObject);
begin

  readApplicationList;

  showApplication;

end;

procedure TNayewilu.leftBtnClick(Sender: TObject);
begin

  if currentIndex > 0 then
  begin
    showApplication(currentIndex-1);
  end;

end;

procedure TNayewilu.rightBtnClick(Sender: TObject);
begin

  if currentIndex < maxIndex then
  begin
    showApplication(currentIndex+1);
  end;
  
  
end;

procedure TNayewilu.searchBtnClick(Sender: TObject);
var
  inputText : string;
  i, newIndex, memoArrayLength: Integer;
  memo : array of string;
begin
  inputText := searchBox.Text;

  if CompareText(inputText, '') = 0 then
  begin
    for i := 0 to Length(allApplicationArray)-1 do
      currentApplicationArray[i] := allApplicationArray[i];
    
  end
  else
  begin
    for i := 0 to Length(allApplicationArray)-1 do
      currentApplicationArray[i] := '';

    newIndex := 0;
  
    for i := 0 to maxIndex-1 do
    begin
      memoArrayLength := ExtractStrings(['/', '\'], [' '], PWideChar(allApplicationArray[i]), TStrings(memo));
      if Pos(inputText, memo[memoArrayLength - 1]) > 0 then
      begin
        currentApplicationArray[newIndex] := allApplicationArray[i];
        newIndex := newIndex + 1;
      end;
    
    end;  
  end;
  
  showApplication;

end;

end.
