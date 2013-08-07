/*The source to some plug-ins have been provided
to allow you to help improve and add to the 
abilities of the server. The original code is property
of GuildFTPd and is for the explicit use of you,
the end user, for use with GuildFTPd.

Redistribution or reuse of any parts or whole
of the program code is only authorized when
credit or a reference is provided within your
program or program documentation  that the
code is an original component of GuildFTPd.

Downloading and using any source to any plug-in
assumes your agreement to these guidelines.

By downloading any of these source code archives,
you agree to these established terms. If you do not
agree to the terms outlined, you are restricted from
downloading them. 
We welcome any submitted improvements to any
of the original plug-ins or brand new plug-ins. 
Any such plug-ins will be considered for
distribution on the GuildFTPd website. 
Should we post your plug-in, we will also provide
due credit to you for your work.*/


#ifndef __Chart_Wnd_H
#define __Chart_Wnd_H

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#define No_Set_Font

//#ifndef GRIDCONTROL_NO_TITLETIPS

#ifndef GRIDCONTROL_NO_TITLETIPS
#include "TitleTip.h"
#endif

class CChartItemInfo
{
public:
	CChartItemInfo(CString user , int value, COLORREF color , int icon = -1)
	{ 
		m_UserName  = user;
        m_Value     = value;    
        m_Icon      = icon;
        m_Color     = color;
	}

	~CChartItemInfo() {};

public:
	CString     m_UserName;
    int         m_Value;
    int         m_Icon;
    COLORREF    m_Color;

public:
	CString 	GetUserName()
	{
		return m_UserName;
	}

    int     GetValue()
    {
        return m_Value;
    }

    void    SetValue(int value)
    {
        m_Value = value;
    }

    int     GetIcon()
    {
        return m_Icon;
    }

    COLORREF GetColor()
    {
        return m_Color;        
    }
};

// Chart direction
#define CHART_HORZ              1
#define CHART_VERT              0

// Grid line style
#define LINE_NONE                0
#define LINE_ABOVE               1
#define LINE_BELOW               2

#define LEFT_GAP                10
/////////////////////////////////////////////////////////////////////////////
// CChartWnd window
#define MFCChart_ClassName    _T("MFCChartCtrl")  // Window class name

#include <afxtempl.h>
class CChartWnd : public CWnd
{
	DECLARE_DYNCREATE(CChartWnd)

  // Construction
public:
	CChartWnd();

// Attributes
public:

    ULONG           m_nValueStep;
    float           m_MiniValue;
    float           m_MaxiValue;

    float           m_HorzRatio;
    float           m_VertRatio;

    int             m_nMaxiUserNameIndex;

    ULONG			m_nUserNameWidth;
	ULONG			m_nRulerHeight;

	ULONG			m_nNormalHeight;
	ULONG			m_nNormalWidth;

    ULONG           m_nRulerLeftWidth;

    // Cell size details
    ULONG	        m_nRows, m_nFixedRows, m_nCols, m_nFixedCols;

    int			    m_nMargin;

    int				m_nGridLines;

    BOOL            m_bDirection;
    BOOL            m_bDisplayIcon;
    BOOL            m_bUserNameBack;
    BOOL            m_bDrawSunkenEdge;

    CString         m_strUserColTitle;

	CArray<CChartItemInfo*,CChartItemInfo*> m_MemberArray;

protected:

    // Fonts and images
    LOGFONT         m_Logfont;
    CFont           m_Font;         // for the grid 
    CImageList*     m_pImageList;

protected:
        
    BOOL            m_HasBackColor;

    // General attributes
    COLORREF    m_crTextColour, m_crTextBkColour, m_crBkColour,   // Grid colours
                m_crFixedTextColour, m_crFixedBkColour, m_crGridColour;

    COLORREF    m_crWindowText, m_crWindowColour, m_cr3DFace,     // System colours
                m_crShadow;  

	/* if true, using memDC,  avoid flicking */
    BOOL        m_bDoubleBuffer;


    /* When chart is vertical, display  the  tips  */
    BOOL        m_bTitleTips;

#ifndef GRIDCONTROL_NO_TITLETIPS
    CTitleTip   m_TitleTip;             // Title tips 
#else
    CToolTipCtrl m_TitleTip;
#endif

    BOOL        m_bValueInTips;

    BOOL        m_bAddPercent;

public:
    BOOL            GetEdgeState()                      { return m_bDrawSunkenEdge;         }
    void            SetEdgeState(BOOL has)              { m_bDrawSunkenEdge = has;          }  
    BOOL            GetUserNameBackState()              { return m_bUserNameBack;           }
    void            SetUserNameBackState(BOOL st)       { m_bUserNameBack = st;             }
    BOOL            GetDisplayState()                   {  return m_bDisplayIcon;           }
    void            SetDisplayState(BOOL st)            {  m_bDisplayIcon = st;             }
    void            SetChartVert();
    void            SetChartHorz();
    BOOL            GetChartDirection()                 { return m_bDirection;              }
    void            EnableTitleTips(BOOL bEnable = TRUE);
    BOOL            GetTitleTips()                      { return m_bTitleTips;              }

    void            SetValueInTips(BOOL set =  true)    { m_bValueInTips = set;             }
    BOOL            GetValueInTipsState()               { return m_bValueInTips;            }


	void			SetImageList(CImageList* pList)     { m_pImageList = pList;             }
    CImageList*		GetImageList() const                { return m_pImageList;              }

    int             GetChartItemCount()                 { return m_MemberArray.GetSize();}
    CString         GetUserColTitle()                   { return m_strUserColTitle;         }
    BOOL            SetUserColTitle(CString title);
    void            SetNoBackColor()                    { m_HasBackColor   = false;         }

    BOOL            SetChartFromToValue(float from, float to , int ValueStep =4);

    BOOL            AddChartItem(CString user, int value, COLORREF color,int iconIndex = -1);
    BOOL            RemoveChartItem(int index);
    void            SetChartItem(int index, int value);

    void            RefreshWindow()                     { Invalidate(); UpdateWindow();     }

public:
    BOOL    Initialize();
    BOOL    ReCalculating();
	void	Flush();

public:
    void     SetTextColor(COLORREF clr)           { m_crTextColour = clr;             }
    COLORREF GetTextColor() const                 { return m_crTextColour;            }
    void     SetTextBkColor(COLORREF clr)         { m_crTextBkColour = clr;  m_HasBackColor =true;    }
    COLORREF GetTextBkColor() const               { return m_crTextBkColour;          }
    void     SetBkColor(COLORREF clr)             { m_crBkColour = clr;               }
    COLORREF GetBkColor() const                   { return m_crBkColour;              }
    void     SetFixedTextColor(COLORREF clr)      { m_crFixedTextColour = clr;        }
    COLORREF GetFixedTextColor() const            { return m_crFixedTextColour;       }
    void     SetFixedBkColor(COLORREF clr)        { m_crFixedBkColour = clr;          }
    COLORREF GetFixedBkColor() const              { return m_crFixedBkColour;         } 
    void     SetGridColor(COLORREF clr)           { m_crGridColour = clr;             }
    COLORREF GetGridColor() const                 { return m_crGridColour;            }

    ULONG	GetFixedRowCount() const              { return m_nFixedRows; }
    ULONG	GetFixedColumnCount() const           { return m_nFixedCols; }

    void SetGridLines(int nWhichLines = LINE_NONE) { m_nGridLines = nWhichLines;       } 
    int  GetGridLines() const                     { return m_nGridLines;              }

// Operations
public:
	ULONG			GetUserNameLength()		{ return m_nUserNameWidth;  }
	ULONG			GetRulerLength()		{ return m_nRulerHeight;    }

	ULONG			GetNormalColHeight()	{ return m_nNormalHeight;	}		
	ULONG			GetNormalRowWidth()		{ return m_nNormalWidth;	}

    ULONG	        GetItemCount() const    { return m_nRows; }

    ULONG			GetFixedRowHeight()		const;
    ULONG			GetFixedColumnWidth()	const;
    ULONG			GetRowHeight(int nRow)	const;
    ULONG			GetColumnWidth(int nCol) const;

public:
    void		SetDoubleBuffering(BOOL bBuffer = TRUE)  { m_bDoubleBuffer = bBuffer;        }
    BOOL		GetDoubleBuffering() const               { return m_bDoubleBuffer;           }

public:
    BOOL		Create(DWORD dwStyle, const RECT& rect, CWnd* pParent, UINT nID = NULL);
    BOOL        SubclassWindow(HWND hWnd);

protected:

    void	EraseBkgnd(CDC* pDC);
	void	DrawNormal(CDC* pDC);
	void	DrawTimeRuler(CDC* pDC);

	void	DrawUserLine(CDC* pDC, int index);

    BOOL	DrawChart(CDC* pDC, int index,BOOL bEraseBk=FALSE);

	void	DrawGridLines(CDC* pDC);

    BOOL	RegisterWindowClass();

public:
	LONG	HitTest(CPoint pt);

private:
	void    PaintFromToRect(CDC *pDC, const RECT &rect,int PaintRGB);
    void    ChangeItemToRandomValue();
    
public:  //functions to get value of items;
    CString     GetUserName(int UserIndex);
    int         GetItemValue(int UserIndex);
    int         GetItemIcon(int UserIndex);
    COLORREF    GetItemColor(int UserIndex);

protected:
// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CChartWnd)
	//}}AFX_VIRTUAL
// Implementation
public:
	virtual ~CChartWnd();
	virtual BOOL PreCreateWindow (CREATESTRUCT&);

	// Generated message map functions
protected:
	//{{AFX_MSG(CChartWnd)
	afx_msg void OnPaint();
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
    afx_msg BOOL OnEraseBkgnd(CDC* pDC);
    afx_msg void OnSysColorChange();
#ifndef No_Set_Font
    afx_msg LRESULT OnSetFont(WPARAM hFont, LPARAM lParam);
    afx_msg LRESULT OnGetFont(WPARAM hFont, LPARAM lParam);
#endif

	afx_msg void OnRButtonDown(UINT nFlags, CPoint point);
    afx_msg void OnTimer(UINT nID);
    afx_msg void OnClose();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////
//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // __Chart_Wnd_H
