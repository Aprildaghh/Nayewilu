unit Unit1;

interface

uses
  FileCtrl, System.IOUtils, ShellAPI, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

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
  private
    { Private declarations }
    
  public
    { Public declarations }
  end;

var
  Nayewilu: TNayewilu;
  currentIndex, maxIndex : integer;
  allApplicationArray, currentApplicationArray : array[0 .. 150] of string;
  textFilePath : string = 'C:/nayewilu.txt';

implementation

{$R *.dfm}
// function to open app or dir
// ShellExecute(Application.Handle, PChar('open'), PChar('explorer.exe'), PChar('/select'), nil, SW_SHOWNORMAL);

procedure readApplicationList;
var
  i : integer;
  line: string;
  inputFile : File;
begin

  if FileExists(textFilePath) then
  begin
    i := 0;
    AssignFile(inputFile, textFilePath);
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

procedure showApplication(index : integer = 0);
begin
  currentIndex := index;
end;

procedure removeApplication(index : integer ; arr : array of string);
begin

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
    allApplicationArray[maxIndex] := selectedFile;
    currentApplicationArray[maxIndex] := selectedFile;
    maxIndex := maxIndex +1;
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
    allApplicationArray[maxIndex] := selectedFile;
    currentApplicationArray[maxIndex] := selectedFile;
    maxIndex := maxIndex +1;
  end;


end;

procedure TNayewilu.FormCreate(Sender: TObject);
begin

  readApplicationList;

  showApplication;

end;

procedure TNayewilu.FormDestroy(Sender: TObject);
begin
  // save all application and directories to a text file under C:/nayewilu.txt
end;

procedure TNayewilu.leftBtnClick(Sender: TObject);
begin

  if currentIndex > 0 then
  begin
    showApplication(currentIndex-1);
  end;

end;

procedure TNayewilu.removeBtnClick(Sender: TObject);
begin
  removeApplication(currentIndex, currentApplicationArray);
  removeApplication(currentIndex, allApplicationArray);
  currentIndex := currentIndex -1;
  maxIndex := maxIndex -1;
  showApplication(currentIndex);
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
  
    for i := 0 to Length(allApplicationArray)-1 do
    begin
      memoArrayLength := ExtractStrings(['/', '\'], [' '], PWideChar(allApplicationArray[i]), TStrings(memo));
      if Pos(inputText, memo[memoArrayLength - 1]) > 0 then
      begin
        currentApplicationArray[newIndex] := allApplicationArray[i];
        newIndex := newIndex + 1;
      end;
    
    end;
    maxIndex := Length(currentApplicationArray)-1;
  end;

  showApplication;

end;

end.
