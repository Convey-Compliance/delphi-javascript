unit Unit12;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, js15decl,jsintf, StdCtrls, Vcl.Buttons;

type

  [JSClassName('App')]
  TJSAppObject = class(TJSClass)
  public
    procedure testCall;

  end;

  TForm12 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FJSEngine: TJSEngine;
    FJSAppObject: TJSAppObject;
    FDT: TDateTime;
    function GetTestDT: TDateTime;
    procedure SetTestDT(const Value: TDateTime);
  public
    { Public declarations }
    procedure testjs;

    [JSExclude()]
    procedure testjsother;
    property TestDateTime: TDateTime read GetTestDT write SetTestDT;
  end;

  // This is been used for regsitering delphi procedures @ JS Global context
  // all class methods will be registered, anything else will be ignored

  TJSGlobalFunctions = class
    class procedure ShowMessage(s: string);
    class function FileExists(n: string): boolean;
  end;

var
  Form12: TForm12;

implementation
uses RTTI, typinfo;

{$R *.dfm}

procedure TForm12.BitBtn1Click(Sender: TObject);
var
  i : integer;
  t : Cardinal;
  res : jsval;
begin
  t := GetTickCount;
  memo1.lines.BeginUpdate;
  for i := 1 to 100000 do
    begin
      //if not FJSEngine.Evaluate('testStr("hello")', res) then
      if not FJSEngine.callFunction('testStr', ['hello', 123], res) then
        raise Exception.Create('Error Message');
      //memo1.lines.add(JSValToString(FJSEngine.Context, res));
      if i mod 1000 = 0 then
        FJSEngine.GarbageCollect;
    end;
  memo1.lines.EndUpdate;
  ShowMessage(IntToStr(GetTickCount - t));
end;

procedure TForm12.FormCreate(Sender: TObject);
begin
  FDT := now;
  FJSEngine := TJSEngine.Create;
  FJSEngine.registerGlobalFunctions(TJSGlobalFunctions);
  FJSEngine.registerClasses([TStreamWriter,TEdit, TForm, TLabel, TCheckBox, TFileStream, TStringList], [cfaInheritedMethods,     // Publish inherited methods
                                   cfaProtectedMethods,     // publish protected methods
                                   cfaProtectedFields,
                                   cfaInheritedProperties,  // Publish inherited properties
                                   cfaOwnObject,            // Free object on javascript destructor
                                   cfaGlobalFields,         // Register Private fields as properties to global object
                                   cfaGlobalProperties]);
  FJSAppObject:= TJSAppObject.CreateJSObject(FJSEngine, 'App') ;
  //FJSAppObject.JSObject
  //FJSAppObject.JSObject.Evaluate('this.testCall();');
  TJSClass.CreateJSObject(Self, FJSEngine, 'MainForm', [cfaInheritedMethods, cfaInheritedProperties]);
//  FJSEngine.Evaluate(TJSScript.LoadScript('test.js'), ':ApplicationInitScript:');
  FJSEngine.EvaluateFile('test.js');
  FJSEngine.CallFunction('main');
end;

procedure TForm12.FormDestroy(Sender: TObject);
begin
  FJSEngine.free;
end;


function TForm12.GetTestDT: TDateTime;
begin
  result := FDT ;
end;

procedure TForm12.SetTestDT(const Value: TDateTime);
begin
  fdt := value;
end;

procedure TForm12.testjs;
var s: string;
begin
  s := '';
  s := 'asdsda';
end;

procedure TForm12.testjsother;
begin
//
end;

{ TJSGlobalFunctions }

class function TJSGlobalFunctions.FileExists(n: string): boolean;
begin
  Result := SysUtils.FileExists(n)
end;

class procedure TJSGlobalFunctions.ShowMessage(s: string);
begin
  Dialogs.ShowMessage(s);
end;

{ TJSAppObject }

procedure TJSAppObject.testCall;
begin
  Form12.Memo1.Lines.Add('testCall');
end;

end.
