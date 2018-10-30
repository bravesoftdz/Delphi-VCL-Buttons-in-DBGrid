unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Data.DB, Vcl.Grids,  Vcl.DBGrids,vcl.themes,
  vcl.extctrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons,
   Datasnap.DBClient;

   Type
    TModDbGrid = class(TCustomGrid)
    end;
   TForm4 = class(TForm)
    DBGrid1: TDBGrid;
    Button2: TButton;
    Button1: TButton;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    Panel1: TPanel;
    cbxVclStyles: TComboBox;
    Label1: TLabel;
    procedure DBGrid1DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure cbxVclStylesChange(Sender: TObject);
     private
       { Private declarations }
    procedure ButtondrawColumnCell(Sender: TObject;Button:Tbutton;
    Btncaption:string;Datacol,YourCol: Integer; Column: TColumn;
    Grid: TDBGrid; const Rect: TRect; State: TGridDrawState);
  public
     { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
begin
  showmessage('Edit this row');
  end;

procedure TForm4.Button2Click(Sender: TObject);
begin
 showmessage('Delete this Information ');
end;

procedure TForm4.cbxVclStylesChange(Sender: TObject);
begin
     TStyleManager.SetStyle(cbxVclStyles.Text);
end;

procedure TForm4.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
const
 DeleteName:string = 'Delete';
 EditName:string = 'Edit';
var
 R,DataRect: TRect;
 style: DWORD;
 FButtonCol :integer;

 FCellDown:TGridCoord;
begin
 //Change color if the white space below the grid to same as background
 TModDBGrid(sender).FInternalColor:= styleservices.GetStyleColor(scCategoryPanelGroup);

  ButtondrawColumnCell(Sender,Button1,'Edit',Datacol,7,Column,dbGrid1,Rect,State);
  ButtondrawColumnCell(Sender,Button2,'Delete',Datacol,8,Column,DbGrid1,Rect,State);
end;



procedure TForm4.FormCreate(Sender: TObject);
 var
  StyleName: string;
begin
   for StyleName in TStyleManager.StyleNames do
    cbxVclStyles.Items.Add(StyleName);

   cbxVclStyles.itemindex:= 1;
  //set style

  cbxVclStyles.ItemIndex := cbxVclStyles.Items.IndexOf(TStyleManager.ActiveStyle.Name);
 // set up the buttons
 button1.Parent:= dbgrid1;
 button1.Caption:= 'Edit';
 button1.ControlStyle:= button1.ControlStyle +[csClickEvents];
 button2.Parent:= dbgrid1;
 button2.Caption:= 'Delete';
 button2.ControlStyle:= button2.ControlStyle +[csClickEvents];
 end;

 procedure TForm4.Buttondrawcolumncell(Sender: TObject;Button:Tbutton;Btncaption:string;Datacol,YourCol: Integer; Column: TColumn; Grid: TDBGrid; const Rect: TRect; State: TGridDrawState);
var
 R,DataRect: TRect;
 style: DWORD;
 FButtonCol :integer;

 FCellDown:TGridCoord;
 begin
    R := rect;
    inflaterect(R,-1,-1);
    //Set up Button
    if (not (gdFixed in State)) and (DataCol = YourCol) then
  begin
    if styleservices.Enabled then
    TDBGrid(Sender).Canvas.Brush.Color := styleservices.GetStyleColor(scButtonDisabled)
    else
    TDBGrid(Sender).Canvas.Brush.Color := clbtnface;

    style := DFCS_INACTIVE or DFCS_ADJUSTRECT;
   // if (FCellDown.X = DataCol) Then
   //   style := style or DFCS_PUSHED;
     DrawFrameControl( grid.Canvas.Handle, r, DFC_BUTTON, style );
     TDBGrid(Sender).DefaultDrawColumnCell(R, DataCol, Column, State);
     TDBGrid(Sender).Canvas.Brush.Style:= bsclear;
     if styleservices.enabled then
      TDBGrid(Sender).Canvas.Font.Color  := Styleservices.GetStyleFontColor(sfButtonTextdisabled)
      else
     TDBGrid(Sender).Canvas.Font.Color  := clblack;

     DrawText(Grid.Canvas.Handle, PChar(BtnCaption), -1, r, DT_CENTER );
     TDBGrid(Sender).DefaultDrawColumnCell(R, DataCol, Column, State);
  end;

  if grid.DataSource.DataSet.RecNo <= grid.DataSource.DataSet.recordcount  then
 begin
  if (not (gdFixed in State)) and (DataCol = YourCol) then
  begin
     DataRect := TModDbGrid(grid).CellRect((YourCol+1),TModDbGrid(grid).row);
     Inflaterect(datarect,-1,-1);
     button.Width:= Datarect.Width;
     button.left := (DataRect.right - button.width) ;
     button.top := DataRect.top ;
     button.height := (DataRect.bottom-DataRect.top);
     button.visible:= true;
        end;
  end;
 end;

end.
