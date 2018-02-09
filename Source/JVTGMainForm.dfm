object frmJEDIVCSToGit: TfrmJEDIVCSToGit
  Left = 0
  Top = 0
  Caption = 'JEDIVCS To Git'
  ClientHeight = 539
  ClientWidth = 840
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 840
    Height = 41
    Align = alTop
    TabOrder = 0
    DesignSize = (
      840
      41)
    object lblGitRepoPath: TLabel
      Left = 319
      Top = 9
      Width = 108
      Height = 16
      Caption = 'Git Repository Path'
    end
    object lblProjectNamePattern: TLabel
      Left = 8
      Top = 12
      Width = 122
      Height = 16
      Caption = 'Project Name Pattern'
    end
    object edtGitRepoPath: TEdit
      Left = 433
      Top = 9
      Width = 297
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object btnGetRevisions: TButton
      Left = 736
      Top = 6
      Width = 96
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Get Revisions'
      TabOrder = 1
      OnClick = btnGetRevisionsClick
    end
    object edtProjectNamePattern: TEdit
      Left = 144
      Top = 8
      Width = 169
      Height = 24
      TabOrder = 2
      Text = 'edtProjectNamePattern'
      OnExit = edtProjectNamePatternExit
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 520
    Width = 840
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object pnlMainqq: TPanel
    Left = 0
    Top = 41
    Width = 840
    Height = 479
    Align = alClient
    Caption = 'pnlMain'
    TabOrder = 2
    ExplicitLeft = 336
    ExplicitTop = 264
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Splitter: TSplitter
      Left = 1
      Top = 367
      Width = 838
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ResizeStyle = rsUpdate
      ExplicitLeft = -6
      ExplicitTop = 358
    end
    object pnlMain: TPanel
      Left = 1
      Top = 1
      Width = 838
      Height = 366
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pnlMasterDetail'
      TabOrder = 0
      ExplicitLeft = 0
      ExplicitTop = 41
      ExplicitWidth = 840
      ExplicitHeight = 368
      object DBGrid: TDBGrid
        Left = 0
        Top = 0
        Width = 838
        Height = 252
        Align = alClient
        DataSource = RevisionsDataSource
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object BlobsGrid: TDBGrid
        Left = 0
        Top = 252
        Width = 838
        Height = 114
        Align = alBottom
        DataSource = BlobsDataSource
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object mmoGitOutput: TMemo
      Left = 1
      Top = 370
      Width = 838
      Height = 108
      Align = alBottom
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 1
      ExplicitLeft = 0
      ExplicitTop = 412
      ExplicitWidth = 840
    end
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'SERVER=SEASONSFALL0001\SQLEXPRESS2008'
      'OSAuthent=Yes'
      'ApplicationName=Enterprise/Architect/Ultimate'
      'Workstation=SEASONSFALL0001'
      'MARS=yes'
      'ODBCAdvanced=ServerSPN=JEDIVCS24'
      'Database=JEDIVCS24'
      'DriverID=MSSQL'
      'User_Name=sysdba')
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 88
  end
  object RevisionsDataSource: TDataSource
    DataSet = RevisionsFDQuery
    Left = 744
    Top = 96
  end
  object RevisionsFDQuery: TFDQuery
    Active = True
    IndexFieldNames = 'ProjectID'
    MasterFields = 'ProjectID'
    Connection = FDConnection
    SQL.Strings = (
      'SELECT'
      '  P.PROJECTID, P.NAME AS [Project  name],'
      '  M.MODULEID, M.NAME AS [Module Name], M.PATH,'
      '  R.REVISIONID, R.VERSION, R.REVISION, R.COMMENT_I,'
      '  VL.TSTAMP, VL.DESCRIPTION'
      'FROM projects P'
      '  INNER JOIN pjmodule PM ON P.PROJECTID = PM.PROJECTID'
      '  INNER JOIN modules M ON PM.MODULEID = M.MODULEID'
      '  INNER JOIN revision R ON M.MODULEID = R.MODULEID'
      '  INNER JOIN logcomm L ON L.REVISIONID = R.REVISIONID'
      '  INNER JOIN vcslog VL ON L.LOGID = VL.LOGID'
      'WHERE'
      '  P.NAME LIKE !ProjectNamePattern'
      'ORDER BY'
      '  TSTAMP, MODULEID, VERSION, REVISION')
    Left = 632
    Top = 96
    MacroData = <
      item
        Value = 'BrowseAndDocIt%'
        Name = 'PROJECTNAMEPATTERN'
        DataType = mdString
      end>
  end
  object BlobsFDQuery: TFDQuery
    Active = True
    IndexFieldNames = 'revisionid'
    MasterSource = RevisionsDataSource
    MasterFields = 'revisionid'
    Connection = FDConnection
    SQL.Strings = (
      'SELECT *'
      'FROM Blobs')
    Left = 640
    Top = 344
  end
  object BlobsDataSource: TDataSource
    DataSet = BlobsFDQuery
    Left = 744
    Top = 352
  end
end
