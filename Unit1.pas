unit Unit1;

interface

uses
  FileCtrl, System.IOUtils, ShellAPI, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg;

type
  TNayewilu = class(TForm)
    rightBtn: TButton;
    leftBtn: TButton;
    appLabel: TLabel;
    openBtn: TButton;
    searchBox: TEdit;
    searchBtn: TButton;
    imageBox: TImage;
    addAppBtn: TButton;
    addDirBtn: TButton;
    removeBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure rightBtnClick(Sender: TObject);
    procedure leftBtnClick(Sender: TObject);
    procedure searchBtnClick(Sender: TObject);
    procedure addAppBtnClick(Sender: TObject);
    procedure addDirBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure removeBtnClick(Sender: TObject);
    procedure openBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Nayewilu: TNayewilu;
  currentIndex, maxIndex : integer;
  allApplicationArray, currentApplicationArray : array[0 .. 150] of string;
  textFilePath : string = 'nayewilu.txt';

implementation

{$R *.dfm}

procedure readApplicationList;
var
  i : integer;
  line: string;
  inputFile : textFile;
begin

  if FileExists(textFilePath) then
  begin
    i := 0;
    AssignFile(inputFile, textFilePath);
    Reset(inputFile);
    while not Eof(inputFile) do
    begin
      Readln(inputFile, line);
      allApplicationArray[i] := line;
      currentApplicationArray[i] := line;
      i := i+1;
    end;
    maxIndex := i - 1;
    CloseFile(inputFile);
  end
  else
  begin
    maxIndex := -1;
    currentIndex := -1;
  end;


end;

function getName(index : Integer ; arr : array of string) : string;
var
  theResult, theStr : string;
  i : integer;
begin
  theStr :=  arr[index];

  for i := 1 to Length(theStr) do
  begin
    if theStr[i] = '\' then
    begin
      theResult := '';
      Continue;
    end;
    theResult := theResult + theStr[i];
  end;

  Result := theResult;
end;

procedure showApplication( var myLabel : TLabel ; var image : TImage ; index : integer = 0);
begin
  currentIndex := index;

  myLabel.Caption := getName(currentIndex, currentApplicationArray);

end;

procedure removeApplication();
var
  i: Integer;
  found : Boolean;
begin
  for i := currentIndex+1 to Length(currentApplicationArray)-1 do
  begin
    currentApplicationArray[i-1] := currentApplicationArray[i];
  end;

  found := False;

  for i := 0 to Length(allApplicationArray)-1 do
  begin

    if found then
    begin
      allApplicationArray[i-1] := allApplicationArray[i];
    end;

    if currentApplicationArray[i] = allApplicationArray[i] then
      found := True;
  end;
end;

procedure TNayewilu.addAppBtnClick(Sender: TObject);
var
  selectedFile: string;
  dlg: TOpenDialog;
begin
  selectedFile := '';
  dlg := TOpenDialog.Create(nil);
  try
    dlg.InitialDir := 'C:\';
    dlg.Filter := 'All files (*.*)|*.*|*';
    if dlg.Execute(Handle) then
      selectedFile := dlg.FileName;
  finally
    dlg.Free;
  end;

  if selectedFile <> '' then
  begin
    maxIndex := maxIndex +1;
    allApplicationArray[maxIndex] := selectedFile;
    currentApplicationArray[maxIndex] := selectedFile;
  end;

end;

procedure TNayewilu.addDirBtnClick(Sender: TObject);
var
  selectedFile: string;
  dlg: TFileOpenDialog;
begin
  selectedFile := '';
  dlg := TFileOpenDialog.Create(nil);
  try
    dlg.Title := 'C:\';
    dlg.Options := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem];
    if dlg.Execute then
      selectedFile := dlg.FileName;
  finally
    dlg.Free;
  end;

  if selectedFile <> '' then
  begin
    maxIndex := maxIndex +1;
    allApplicationArray[maxIndex] := selectedFile;
    currentApplicationArray[maxIndex] := selectedFile;
  end;


end;

procedure TNayewilu.FormCreate(Sender: TObject);
begin
  readApplicationList;

  showApplication(appLabel, imageBox);
end;

procedure TNayewilu.FormDestroy(Sender: TObject);
var
  myFile : textFile;
  i: Integer;
begin
  AssignFile(myFile, textFilePath);

  ReWrite(myFile);

  for i := 0 to Length(allApplicationArray)-1 do
  begin
    if allApplicationArray[i] <> '' then
      writeLn(myFile, allApplicationArray[i]);
  end;

  CloseFile(myFile);
end;

procedure TNayewilu.leftBtnClick(Sender: TObject);
begin

  if currentIndex > 0 then
  begin
    showApplication(appLabel, imageBox, currentIndex-1);
  end;

end;

procedure TNayewilu.openBtnClick(Sender: TObject);
begin
  ShellExecute(0, 'open', PWideChar(currentApplicationArray[currentIndex]), nil, nil, SW_SHOW);
end;

procedure TNayewilu.removeBtnClick(Sender: TObject);
begin
  removeApplication();
  currentIndex := currentIndex -1;
  maxIndex := maxIndex -1;
  showApplication(appLabel, imageBox, currentIndex);
end;

procedure TNayewilu.rightBtnClick(Sender: TObject);
begin

  if currentIndex < maxIndex then
  begin
    showApplication(appLabel, imageBox, currentIndex+1);
  end;

end;

procedure TNayewilu.searchBtnClick(Sender: TObject);
var
  inputText, appName : string;
  i, newIndex: Integer;
begin
  inputText := searchBox.Text;

  if CompareText(inputText, '') = 0 then
  begin
    newIndex := 0;

    for i := 0 to Length(allApplicationArray)-1 do
    begin
      if allApplicationArray[i] <> '' then
      begin
        currentApplicationArray[i] := allApplicationArray[i];
        newIndex := newIndex + 1;
      end;
    end;

    maxIndex := newIndex-1;

  end
  else
  begin
    for i := 0 to Length(allApplicationArray)-1 do
      currentApplicationArray[i] := '';

    newIndex := 0;
  
    for i := 0 to Length(allApplicationArray)-1 do
    begin
      appName := getName(i, allApplicationArray);
      if Pos(inputText, appName) > 0 then
      begin
        currentApplicationArray[newIndex] := allApplicationArray[i];
        newIndex := newIndex + 1;
      end;

    end;
    maxIndex := newIndex-1;
  end;

  showApplication(appLabel, imageBox);

end;

end.
