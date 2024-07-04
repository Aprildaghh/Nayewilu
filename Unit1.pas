unit Unit1;

interface

uses
  FileCtrl, System.IOUtils, ShellAPI, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, System.Generics.Collections;

type
  TNayewilu = class(TForm)
    openBtn: TButton;
    searchBox: TEdit;
    addAppBtn: TButton;
    addDirBtn: TButton;
    removeBtn: TButton;
    listBox: TListBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure addAppBtnClick(Sender: TObject);
    procedure addDirBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure removeBtnClick(Sender: TObject);
    procedure openBtnClick(Sender: TObject);
    procedure searchBoxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TApplication = class
    name, path: string;
    constructor Create(tName, tPath: string);
  end;

var
  Nayewilu        : TNayewilu;
  allApplications : TList<TApplication>;
  filter          : string;
  textFilePath    : string;

implementation

{$R *.dfm}

constructor TApplication.Create(tName: string; tPath: string);
begin
  self.name := tName;
  self.path := tPath;
end;

function getName(path: string) : string;
var
  theResult : string;
  i : integer;
begin

  for i := 1 to Length(path) do
  begin
    if path[i] = '\' then
    begin
      theResult := '';
      Continue;
    end;
    theResult := theResult + path[i];
  end;

  Result := theResult;
end;

function getSelectedApp: TApplication;
var
  i: Integer;
begin
  for i := 0 to Nayewilu.listBox.Count - 1 do
    if Nayewilu.listBox.Selected[i] then
    begin
      Result := allApplications.Items[i];
      Exit;
    end;
  Result := nil;

end;

function updateList: boolean;
var
  i: Integer;
begin
  filter := Nayewilu.searchBox.Text;
  Nayewilu.listBox.Clear;
  if filter = '' then
  begin
    for i := 0 to allApplications.Count - 1 do
      Nayewilu.listBox.AddItem(allApplications.Items[i].name, nil);
    Exit;
  end;
  for i := 0 to allApplications.Count - 1 do
    if allApplications.Items[i].name.ToLower.Contains(filter.ToLower) then Nayewilu.listBox.AddItem(allApplications.Items[i].name, nil);

end;

procedure readApplicationList;
var
  line: string;
  inputFile : textFile;
begin

  if FileExists(textFilePath) then
  begin
    AssignFile(inputFile, textFilePath);
    Reset(inputFile);
    while not Eof(inputFile) do
    begin
      Readln(inputFile, line);
      allApplications.Add(TApplication.Create(getName(line), line));
    end;
    CloseFile(inputFile);
  end

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
    allApplications.add(TApplication.Create(getName(selectedFile), selectedFile));

  updateList;
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
    allApplications.add(TApplication.Create(getName(selectedFile), selectedFile));

  updateList;
end;

procedure TNayewilu.FormCreate(Sender: TObject);
begin

  textFilePath := GetEnvironmentVariable('appdata') + '\nayewilu';

  try
    mkdir(textFilePath);
  except
  end;

  textFilePath := textFilePath + '\nayewilu.txt';

  allApplications := TList<TApplication>.Create;
  readApplicationList;

  updateList;
end;

procedure TNayewilu.FormDestroy(Sender: TObject);
var
  myFile : textFile;
  i: Integer;
begin
  AssignFile(myFile, textFilePath);

  ReWrite(myFile);

  for i := 0 to allApplications.Count-1 do
    if allApplications.Items[i].path <> '' then
      writeLn(myFile, allApplications.Items[i].path);

  CloseFile(myFile);
end;

procedure TNayewilu.openBtnClick(Sender: TObject);
var
  theApp: TApplication;
begin
  theApp := getSelectedApp;

  if theApp <> nil then
    ShellExecute(0, 'open', PWideChar(theApp.path), nil, nil, SW_SHOW);
end;

procedure TNayewilu.removeBtnClick(Sender: TObject);
var
  deletedApp: TApplication;
begin
  deletedApp := getSelectedApp;
  allApplications.Remove(deletedApp);
  deletedApp.Free;
  Nayewilu.listBox.DeleteSelected;
end;

procedure TNayewilu.searchBoxKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  updateList;
end;

end.
// make the text file save in appdata/roaming
