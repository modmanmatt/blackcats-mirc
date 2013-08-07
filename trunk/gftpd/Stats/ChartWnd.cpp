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

#include "stdafx.h"
#include "resource.h"
#include "ChartWnd.h"
#include "MemDC.h"

#include "Drawcube.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

static COLORREF tmpColor[]=
{
    RGB(0,0,0), RGB(0,0,160),RGB(128,0,128), RGB(26,166,57),
    RGB(0,128,0),RGB(0,128,128),RGB(220,0,0),RGB(128,128,0)
};

/////////////////////////////////////////////////////////////////////////////
// CChartWnd
/////////////////////////////////////////////////////////////////////////////
#define LEFT_MARGIN         4
#define RIGHT_MARGIN        20
#define TOP_MARGIN          12
#define BOTTOM_MARGIN       1 
#define GAP                 1

#define USER_COL_TITLE      "User"
#define UNIT_STRING         "%"

#define TIMER_ID            1

IMPLEMENT_DYNCREATE(CChartWnd, CWnd)
CChartWnd::CChartWnd()
{
	RegisterWindowClass();

    m_nValueStep            =   4;
    m_MiniValue             =   0;
    m_MaxiValue             =   24;
    m_strUserColTitle       =   USER_COL_TITLE;
    
    m_nMaxiUserNameIndex   =   -1;
    m_nGridLines            =   LINE_BELOW;

    m_HasBackColor          =   true;

	m_nNormalWidth			=	24;
    m_nNormalHeight         =   24;

    m_nRulerHeight	    	=	24;
	m_nUserNameWidth		=	60;

    m_nRulerLeftWidth       =   40;

    // Store the system colours in case they change. The gridctrl uses
    // these colours, and in OnSysColorChange we can check to see if 
    // the gridctrl colours have been changed from the system colours.
    // If they have, then leave them, otherwise change them to reflect
    // the new system colours.
    m_crWindowText       = ::GetSysColor(COLOR_WINDOWTEXT);
    m_crWindowColour     = RGB(255,255,212);//::GetSysColor(COLOR_WINDOW);
    m_cr3DFace           = ::GetSysColor(COLOR_3DFACE);
    m_crShadow           = ::GetSysColor(COLOR_3DSHADOW);

    m_nFixedRows         = 1;
    m_nFixedCols         = 1;
	m_nRows				 = 8;
	m_nCols				 = 2;

    m_nMargin            = 3;

    m_bDoubleBuffer      = true;      // Use double buffering to avoid flicker?
    m_pImageList         = NULL;      

    // Initially use the system message font for the TimeZoneCtrl font
    NONCLIENTMETRICS ncm;
    ncm.cbSize = sizeof(NONCLIENTMETRICS);
    VERIFY(SystemParametersInfo(SPI_GETNONCLIENTMETRICS, sizeof(NONCLIENTMETRICS), &ncm, 0));    
    memcpy(&m_Logfont, &(ncm.lfMessageFont), sizeof(LOGFONT));

    // Set the colours
    SetTextColor(m_crWindowText);
    SetTextBkColor(m_crWindowColour);
    SetBkColor(m_crShadow);
    SetFixedTextColor(m_crWindowText);
    SetFixedBkColor(m_cr3DFace);

    m_crGridColour      = RGB(0,128,0);

    m_bDisplayIcon      = true;
    m_bUserNameBack     = false;
    m_bDirection        = CHART_HORZ;

    m_HorzRatio         = 1.0;
    m_VertRatio         = 1.0;

    m_bTitleTips        = FALSE;      // show title tips when vertical
    m_bValueInTips      = true;

    m_bAddPercent       = false;
	m_bDrawSunkenEdge	= false;

    m_Font.CreateFont (14, 0, 0, 0, 300,
                       FALSE, FALSE, 0, ANSI_CHARSET,
                       OUT_DEFAULT_PRECIS, 
                       CLIP_DEFAULT_PRECIS,
                       DEFAULT_QUALITY, 
                       DEFAULT_PITCH|FF_SWISS, "Arial") ;
}

BOOL CChartWnd::RegisterWindowClass()
{
    WNDCLASS wndcls;
    HINSTANCE hInst = AfxGetInstanceHandle();
   // HINSTANCE hInst = AfxGetResourceHandle(); 

    if (!(::GetClassInfo(hInst, MFCChart_ClassName, &wndcls)))
    {
        // otherwise we need to register a new class
        wndcls.style            = CS_DBLCLKS;// | CS_HREDRAW | CS_VREDRAW;
        wndcls.lpfnWndProc      = ::DefWindowProc;
        wndcls.cbClsExtra       = wndcls.cbWndExtra = 0;
        wndcls.hInstance        = hInst;
        wndcls.hIcon            = NULL;
        wndcls.hCursor          = AfxGetApp()->LoadStandardCursor(IDC_ARROW);
        wndcls.hbrBackground    = NULL;//(HBRUSH)(COLOR_BTNFACE); //(COLOR_3DFACE + 1);
        wndcls.lpszMenuName     = NULL;
        wndcls.lpszClassName    = MFCChart_ClassName;

        if (!AfxRegisterClass(&wndcls)) {
            AfxThrowResourceException();
            return FALSE;
        }
    }

    return TRUE;
}

CChartWnd::~CChartWnd()
{
	Flush();
    m_Font.DeleteObject();
}

void CChartWnd::Flush()
{
	for(int i=0;i<m_MemberArray.GetSize();i++)
	{
		CChartItemInfo* zone = (CChartItemInfo*)m_MemberArray.GetAt(i);
		if(zone)
			delete zone;
	}
	m_MemberArray.RemoveAll();

    m_nMaxiUserNameIndex   =   -1;
}

BEGIN_MESSAGE_MAP(CChartWnd, CWnd)
	//{{AFX_MSG_MAP(CChartWnd)
	ON_WM_PAINT()
	ON_WM_MOUSEMOVE()
	ON_WM_LBUTTONDOWN()
	ON_WM_LBUTTONUP()
    ON_WM_ERASEBKGND()
	ON_WM_RBUTTONDOWN()
    ON_WM_TIMER()
    ON_WM_CLOSE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

BOOL CChartWnd::PreCreateWindow(CREATESTRUCT& cs) 
{
	//cs.style |= WS_HSCROLL | WS_VSCROLL;
	return CWnd::PreCreateWindow(cs);
}

BOOL CChartWnd::Create(DWORD dwStyle, const RECT& rect, CWnd* pParent, UINT nID /*= NULL*/)
{
    BOOL    result;
    static CString className = AfxRegisterWndClass(CS_HREDRAW | CS_VREDRAW) ;

    result = CWnd::CreateEx(0, 
                          className, NULL, dwStyle, 
                          rect.left, rect.top, rect.right-rect.left, rect.bottom-rect.top,
                          pParent->GetSafeHwnd(), (HMENU)nID) ;

    return result;
}

BOOL CChartWnd::SubclassWindow(HWND hWnd) 
{    
    if (!CWnd::SubclassWindow(hWnd))
        return FALSE;

    return TRUE;
}


void  CChartWnd::EnableTitleTips(BOOL bEnable /*= TRUE*/)
{
    m_bTitleTips    = bEnable;

    if (m_bTitleTips && !IsWindow(m_TitleTip.m_hWnd))
        m_TitleTip.Create(this);

#ifdef GRIDCONTROL_NO_TITLETIPS
    CRect client;
    GetClientRect(&client);

    for(int index =0;index <m_MemberArray.GetSize();index++)
    {
        CRect rect;
    	rect.SetRect(LEFT_MARGIN + m_nRulerLeftWidth +  index* (m_nNormalHeight+8), 
            client.bottom - m_nNormalHeight - LEFT_MARGIN, 
            LEFT_MARGIN + m_nRulerLeftWidth +  (index  +1)* (m_nNormalHeight+8) , 
    		client.bottom - LEFT_MARGIN);

        if(rect.PtInRect(point))
        {
            CString user = GetUserName(index);
            TRACE("Current mouse is in user %d:  %s\n",index+1,user);
            CRect showRect;
            CPoint center = rect.CenterPoint();
            showRect.SetRect(center.x, center.y - TitleTipHeight,center.x + rect.Width(),center.y);
            m_TitleTip.Show(showRect,user); 
        }
    }
#endif

}
////////////////////////////////////////////////////////////////////////////////////
/*
 *	Get Fixed Row Height and Column Width, in this window, only  one column and one row is fixed
 */
ULONG CChartWnd::GetFixedRowHeight() const
{ 
	return m_nRulerHeight;
} 

ULONG CChartWnd::GetFixedColumnWidth() const
{ 
	return m_nUserNameWidth;	
} 

/*
 *	Get RowHeight and ColumnWidth of every item,
 */
ULONG CChartWnd::GetRowHeight(int nRow)	const
{
	if(nRow ==0) /* if first, return m_nRulerHeight;*/
		return m_nRulerHeight;
	return m_nNormalHeight;
}

ULONG CChartWnd::GetColumnWidth(int nCol) const
{
	if(nCol ==0) 
		return m_nUserNameWidth;
	return m_nNormalWidth;
}


///////////////////////////////////////////////////////////////////

void CChartWnd::DrawNormal(CDC* pDC)
{
    CRect rect;
 
    CRect clipRect;
    if (pDC->GetClipBox(&clipRect) == ERROR) 
        return;

	// This necessary since we may be using a Memory DC.
	GetClientRect(&rect);
    
    EraseBkgnd(pDC);            // OnEraseBkgnd does nothing, so erase bkgnd here.
    
	ULONG wndRight		= rect.Width();
	ULONG totalNumber	= m_MemberArray.GetSize();	

    if(totalNumber <=0)
    {
        TRACE("DrawNormal(CDC* pDC): No items!\n");
        return;
    }


	int mode= pDC->SetBkMode(TRANSPARENT);

    DrawUserLine(pDC,-1);

	/*
	 *  Draw Ruler
	 */
	DrawTimeRuler(pDC);

	/*
	 *	Draw Grid Lines;
	 */ 
    if(m_nGridLines == LINE_BELOW)
        DrawGridLines(pDC);

	for(int i= 0;i< m_MemberArray.GetSize();i++)
	{
		DrawUserLine(pDC,i);
		DrawChart(pDC,i);
	}

	/*
	 *	Draw Grid Lines;
	 */ 
    if(m_nGridLines != LINE_BELOW)
        DrawGridLines(pDC);

    /*
     *  Draw an  edge for good look;
     */
    if(m_bDrawSunkenEdge)
    {
        GetClientRect(&rect);
        pDC->DrawEdge(&rect, EDGE_ETCHED, BF_RECT);
    }       
}


/*********************************************************
 *
 * Get value from every item
 *
 ********************************************************/
CString CChartWnd::GetUserName(int UserIndex)
{
	CChartItemInfo* zone = (CChartItemInfo*)m_MemberArray.GetAt(UserIndex);

    if(zone)
	    return zone->GetUserName();
    else
    {
        ASSERT(FALSE);
        return "";
    }
}

int CChartWnd::GetItemValue(int UserIndex)
{
	CChartItemInfo* zone = (CChartItemInfo*)m_MemberArray.GetAt(UserIndex);

    if(zone)
	    return zone->GetValue();
    else
    {
        ASSERT(FALSE);
        return 0;
    }
}

int CChartWnd::GetItemIcon(int UserIndex)
{
	CChartItemInfo* zone = (CChartItemInfo*)m_MemberArray.GetAt(UserIndex);

    if(zone)
	    return zone->GetIcon();
    else
    {
        ASSERT(FALSE);
        return 0;
    }
}

COLORREF CChartWnd::GetItemColor(int UserIndex)
{
	CChartItemInfo* zone = (CChartItemInfo*)m_MemberArray.GetAt(UserIndex);

    if(zone)
	    return zone->GetColor();
    else
    {
        ASSERT(FALSE);
        return RGB(0,0,0);
    }
}
/*   End of Every Item */

void CChartWnd::DrawTimeRuler(CDC* pDC)
{
	int i, xx, veryLeft ,yy;
	int leftx			= m_nUserNameWidth + LEFT_MARGIN;
    CString pStr;

	CFont* pOldFont=pDC->SelectObject(&m_Font);
	int oldBkMode=pDC->SetBkMode(TRANSPARENT);

    if(m_bDirection == CHART_HORZ)
        veryLeft = leftx ;
    else
        veryLeft = 0;

	/* write the time string at the top */
	for(i=0; i<= (int)m_nValueStep ;i++)
	{
        pStr.Format("%d", (int)(m_MiniValue + (m_MaxiValue  - m_MiniValue) *  i/ m_nValueStep));
        if(m_bAddPercent)
            pStr += UNIT_STRING;

        if(m_bDirection == CHART_HORZ)
        {
            xx = m_nUserNameWidth + LEFT_MARGIN + (int)(i* (m_MaxiValue-m_MiniValue)* m_HorzRatio/ m_nValueStep);
            CRect draw;
            draw.SetRect(xx-46, 2, xx+50, 30);
			pDC->DrawText(pStr,&draw,DT_CENTER);
            //pDC->TextOut(xx+2,2,pStr);
        }
        else
        {
            CRect client;
            GetClientRect(&client);

            yy = client.bottom - m_nNormalHeight - LEFT_MARGIN - 
                (int)(i * (m_MaxiValue-m_MiniValue)* m_VertRatio/ m_nValueStep) - 14;

            client.SetRect(2,yy, m_nRulerLeftWidth - 2 * LEFT_MARGIN, yy + m_nNormalHeight);
            pDC->DrawText(pStr,&client,DT_TOP | DT_RIGHT);
        }
	}

	pDC->SelectObject(pOldFont);
//	pDC->SetTextAlign(oldTextAlign);
	pDC->SetBkMode(oldBkMode);
}

void CChartWnd::DrawUserLine(CDC* pDC,int index)
{
    CRect rect;
    GetClientRect(&rect);
  
    CString user;
    if(index < 0) //Just the "User"
    {
        user = m_strUserColTitle;
        if(m_bDirection == CHART_HORZ)
	        rect.SetRect(LEFT_MARGIN,0,m_nUserNameWidth,m_nRulerHeight);
        else
	        rect.SetRect(LEFT_MARGIN,rect.bottom - m_nNormalHeight - LEFT_MARGIN,
                LEFT_MARGIN + m_nRulerLeftWidth, rect.bottom - LEFT_MARGIN);
    }
    else
    {
        user = GetUserName(index);
        if(m_bDirection == CHART_HORZ)
		    rect.SetRect(LEFT_MARGIN,m_nRulerHeight+index * m_nNormalHeight,
			    m_nUserNameWidth,(index +1)*m_nNormalHeight+m_nRulerHeight);
        else
        {
            CRect client;
            GetClientRect(&client);
		    rect.SetRect(LEFT_MARGIN + m_nRulerLeftWidth +  index* (m_nNormalHeight+8), 
                client.bottom - m_nNormalHeight - LEFT_MARGIN, 
                LEFT_MARGIN + m_nRulerLeftWidth +  (index  +1)* (m_nNormalHeight+8) , 
			    client.bottom - LEFT_MARGIN);
        }
    }
 
    CFont* oldFont =(CFont*)pDC->SelectObject(&m_Font);

    if(m_bUserNameBack)
	/* draw border here */
    {
        CPen lightpen(PS_SOLID, 1,  ::GetSysColor(COLOR_3DHIGHLIGHT)),
              darkpen(PS_SOLID,  1, ::GetSysColor(COLOR_3DDKSHADOW)),
             *pOldPen = pDC->GetCurrentPen();
    
        pDC->SelectObject(&lightpen);
        pDC->MoveTo(rect.right, rect.top);
        pDC->LineTo(rect.left, rect.top);
        pDC->LineTo(rect.left, rect.bottom);

        pDC->SelectObject(&darkpen);
        pDC->MoveTo(rect.right, rect.top);
        pDC->LineTo(rect.right, rect.bottom);
        pDC->LineTo(rect.left, rect.bottom);

        pDC->SelectObject(pOldPen);
        rect.DeflateRect(1,1);

		lightpen.DeleteObject();
		darkpen.DeleteObject();
    }

    pDC->SetBkMode(TRANSPARENT);
    rect.DeflateRect(m_nMargin, 0);

	if(index < 0) /* first  one as center*/
		DrawText(pDC->m_hDC, user, -1, rect,DT_CENTER|DT_VCENTER|DT_SINGLELINE);
    else 
    {
		if (m_pImageList)
		{
        IMAGEINFO Info;

		int total	= m_pImageList->GetImageCount();
		if(total >0)
		{
            m_pImageList->GetImageInfo(0, &Info);
		    int nImageWidth = Info.rcImage.right-Info.rcImage.left;//+1;

            int iconIndex = GetItemIcon(index);
			if (!m_pImageList->GetImageInfo(iconIndex, &Info))
                iconIndex = 0;
			if (m_pImageList->GetImageInfo(iconIndex, &Info))
			{
				/* Draw Icon at the center */
				int	top			= rect.top;
				top+= (rect.Height() - Info.rcImage.bottom + Info.rcImage.top)/2;

#if 1
                m_pImageList->Draw(pDC,iconIndex ,CPoint(rect.left, top + 1),ILD_TRANSPARENT);
#else
                DrawIconEx(pDC->m_hDC, rect.left, top + 1, m_pImageList->ExtractIcon(iconIndex),
                        rect.Height()-2,rect.Height()-2,0,NULL, DI_NORMAL);
#endif
			}
    		rect.left += nImageWidth+m_nMargin;
		}
		}
	    if(m_bDirection == CHART_HORZ)
		   // pDC->DrawText(user, &rect,DT_LEFT|DT_VCENTER|DT_SINGLELINE);
           DrawText(pDC->m_hDC, user, -1, rect,DT_LEFT|DT_VCENTER|DT_SINGLELINE);
    }

	pDC->SelectObject(oldFont);
}

static void DrawCubeGrid(CDC* pDC, CRect&  rect,  COLORREF lineColor = RGB(0,128,0))
{
    BOOL        isHorz = true;
    CPoint      from,to;

    if(rect.left == rect.right)
        isHorz = false;

    CPen* oldPen = NULL;

    from     = rect.TopLeft();
    to.x     = rect.right;
    to.y     = rect.bottom;
    
    CPen BorderPen(PS_SOLID,1,lineColor);
    CPen White(PS_SOLID,1,RGB(255,255,255));
    CPen shadowPen(PS_SOLID,1,RGB(170,170,170));

    oldPen = (CPen*)pDC->SelectObject(&White);
    pDC->MoveTo(from);
    pDC->LineTo(to);

    pDC->SelectObject(&BorderPen);

    if(isHorz)
    {
        pDC->MoveTo(from.x,from.y-1);
        pDC->LineTo(to.x,to.y-1);
        pDC->MoveTo(from.x,from.y+1);
        pDC->LineTo(to.x,to.y+1);
        
        pDC->SelectObject(&shadowPen);
        pDC->MoveTo(from.x,from.y+2);
        pDC->LineTo(to.x,to.y+2);
    }
    else
    {
        pDC->MoveTo(from.x-1,from.y);
        pDC->LineTo(to.x-1,to.y);
        pDC->MoveTo(from.x+1,from.y);
        pDC->LineTo(to.x+1,to.y);

        pDC->SelectObject(&shadowPen);
        pDC->MoveTo(from.x+2,from.y);
        pDC->LineTo(to.x+2,to.y);
    }

    pDC->SelectObject(oldPen);

	BorderPen.DeleteObject();
	White.DeleteObject();
	shadowPen.DeleteObject();
}

void CChartWnd::DrawGridLines(CDC* pDC)
{
    CRect client, rect;
    int i;

	CPen*	oldPen = NULL;

    GetClientRect(&client);
	if(LINE_NONE  == m_nGridLines)
    {
	    CPen	pen(PS_SOLID,1,m_crGridColour);
        oldPen = (CPen*)pDC->SelectObject(&pen);

	    /* write the time string at the top */
	    for(i=0; i<= (int)m_nValueStep ;i++)
    	{
            if(m_bDirection == CHART_HORZ)
            {
                int xx = m_nUserNameWidth + LEFT_MARGIN + (int)(i* (m_MaxiValue-m_MiniValue)* m_HorzRatio/ m_nValueStep);
                pDC->MoveTo(xx,m_nRulerHeight -4);
                if(i !=0)
                    pDC->LineTo(xx,m_nRulerHeight -1);
                else
                    //pDC->LineTo(xx,m_nRulerHeight-1+ m_nNormalHeight* GetItemCount());
                    pDC->LineTo(xx,client.bottom-1);
            }
            else
            {
                CRect client;
                GetClientRect(&client);

                int yy = client.bottom - m_nNormalHeight - 2*LEFT_MARGIN -
                    (int)(i * (m_MaxiValue-m_MiniValue)* m_VertRatio/ m_nValueStep);
                pDC->MoveTo(m_nRulerLeftWidth-4, yy);
                if(i !=0)
                    pDC->LineTo(m_nRulerLeftWidth,yy);
                else
                    //pDC->LineTo(m_nRulerLeftWidth + GetItemCount()*m_nNormalWidth,yy);
                    pDC->LineTo(client.right-1,yy);
            }
	    }
		pDC->SelectObject(oldPen);
		pen.DeleteObject();
    }
    else
    {
	    CPen	pen(PS_SOLID,1,m_crGridColour);
        oldPen = (CPen*)pDC->SelectObject(&pen);

	    /* write the time string at the top */
	    for(i=0; i<= (int)m_nValueStep ;i++)
    	{
            if(m_bDirection == CHART_HORZ)
            {
                int xx = m_nUserNameWidth + LEFT_MARGIN + (int)(i* (m_MaxiValue-m_MiniValue)* m_HorzRatio/ m_nValueStep);
                DrawCubeGrid(pDC,CRect(xx,m_nRulerHeight -4,xx,client.bottom-1),m_crGridColour);
            }
            else
            {
                CRect client;
                GetClientRect(&client);

                int yy = client.bottom - m_nNormalHeight - 2*LEFT_MARGIN - 
                    (int)(i * (m_MaxiValue-m_MiniValue)* m_VertRatio/ m_nValueStep);
                DrawCubeGrid(pDC,CRect(m_nRulerLeftWidth-4 ,yy,client.right-1,yy),m_crGridColour);
            }
        }
		pDC->SelectObject(oldPen);
		pen.DeleteObject();
    }
}

// Custom background erasure. This gets called from within the OnDraw function,
// since we will (most likely) be using a memory DC to stop flicker. If we just
// erase the background normally through OnEraseBkgnd, and didn't fill the memDC's
// selected bitmap with colour, then all sorts of vis problems would occur
void CChartWnd::EraseBkgnd(CDC* pDC) 
{
    CRect  VisRect, ClipRect, rect;
    CBrush FixedBack(GetFixedBkColor()),
           TextBack(GetTextBkColor()),		   
           Back(GetBkColor());

    if (pDC->GetClipBox(ClipRect) == ERROR) 
        return;

    GetClientRect(&VisRect);

    // Draw non-fixed cell background
    if(m_HasBackColor)
        pDC->FillRect(VisRect, &TextBack);

    /*
     *   Draw Background in UserNamePart;
     */
    if(m_bUserNameBack)
    {
        if(m_bDirection == CHART_HORZ)
        {
            // Draw Fixed columns background
            int nFixedColumnWidth = GetFixedColumnWidth();
            if (ClipRect.left < nFixedColumnWidth && ClipRect.top < VisRect.bottom)
                pDC->FillRect(CRect(ClipRect.left, ClipRect.top, 
                              nFixedColumnWidth, VisRect.bottom),
                              &FixedBack);
        
            // Draw Fixed rows background
            int nFixedRowHeight = GetFixedRowHeight();
            if (ClipRect.top < nFixedRowHeight && 
                ClipRect.right > nFixedColumnWidth && ClipRect.left < VisRect.right)
                pDC->FillRect(CRect(nFixedColumnWidth-1, ClipRect.top,
                                  VisRect.right, nFixedRowHeight),
                                  &FixedBack);
        }
        else
        {
            // Draw below part;
            pDC->FillRect(CRect(VisRect.left, VisRect.bottom - m_nNormalHeight - LEFT_MARGIN,
                          VisRect.right, VisRect.bottom),
                          &FixedBack);
        
            // Draw Left Ruler background            
            pDC->FillRect(CRect(VisRect.left, VisRect.top,
                              VisRect.left + m_nRulerLeftWidth  + LEFT_MARGIN,VisRect.bottom),
                              &FixedBack);
        }
    }

   FixedBack.DeleteObject();
   TextBack.DeleteObject();
   Back.DeleteObject();

}

////////////////////////////////////////////////////////////////////////////////////

LONG CChartWnd::HitTest(CPoint pt)
{
	return -1;
}

////////////////////////////////////////////////////////////////////////////////////
// TimeZoneWnd message handler
////////////////////////////////////////////////////////////////////////////////////
void CChartWnd::OnPaint() 
{
	CPaintDC dc(this); // device context for painting

    CRect rect;
 	// This necessary since we may be using a Memory DC.
	GetClientRect(&rect);

    /*
     *  zhubin added to avoid paint outside window;
     */
    //rect.InflateRect(-2,-2);
    dc.IntersectClipRect(&rect);

    if (m_bDoubleBuffer)    // Use a memory DC to remove flicker
    {
        CMemDC MemDC(&dc);
        DrawNormal(&MemDC);   
		ReleaseDC(&MemDC);
    }
    else
        DrawNormal(&dc);   
}


#define  TitleTipHeight 16
static g_ShowIndex = -1;
void CChartWnd::OnMouseMove(UINT nFlags, CPoint point) 
{
#ifdef GRIDCONTROL_NO_TITLETIPS
    CWnd::OnMouseMove(nFlags,point);
    return;
#endif

    if(nFlags & MK_LBUTTON || !m_bTitleTips /*|| m_bDirection != CHART_VERT*/)
    {
        CWnd::OnMouseMove(nFlags,point);
        return;
    }

    int index=0;
    CRect client;
    GetClientRect(&client);

    CRect rect,showRect;
    CPoint center;
    if(g_ShowIndex >=0)
    {
        index = g_ShowIndex;
    	rect.SetRect(LEFT_MARGIN + m_nRulerLeftWidth +  index* (m_nNormalHeight+8), 
            client.bottom - m_nNormalHeight - LEFT_MARGIN, 
            LEFT_MARGIN + m_nRulerLeftWidth +  (index  +1)* (m_nNormalHeight+8) , 
    		client.bottom - LEFT_MARGIN);

        /* if still in rect,  return; */
        if(rect.PtInRect(point))
            return;
    
        center = rect.CenterPoint();
        showRect.SetRect(center.x, center.y - TitleTipHeight,center.x + rect.Width(),center.y);
        /* if still in tips rect, return */
        if(showRect.PtInRect(point))
            return;

        /* else release capture, and hide the tip */
        m_TitleTip.Hide();
        ReleaseCapture();
        g_ShowIndex = -1;

        return;
    }


    for(index =0;index <m_MemberArray.GetSize();index++)
    {
    	rect.SetRect(LEFT_MARGIN + m_nRulerLeftWidth +  index* (m_nNormalHeight+8), 
            client.bottom - m_nNormalHeight - LEFT_MARGIN, 
            LEFT_MARGIN + m_nRulerLeftWidth +  (index  +1)* (m_nNormalHeight+8) , 
    		client.bottom - LEFT_MARGIN);

        if(rect.PtInRect(point))
        {
            g_ShowIndex = index; 

            CString user = GetUserName(index);
            TRACE("Current mouse is in user %d:  %s\n",index+1,user);

            if(m_bValueInTips)
            {
                CString tmp;
                tmp.Format("  %d", GetItemValue(index));
                user+= tmp;
                if(m_bAddPercent)
                    user+= UNIT_STRING;
            }

            center = rect.CenterPoint();
            showRect.SetRect(center.x, center.y - TitleTipHeight,center.x + rect.Width(),center.y);
            m_TitleTip.Show(showRect,user); 

            SetCapture();

            return;
        }
    }

	CWnd::OnMouseMove(nFlags, point);
}

void CChartWnd::OnLButtonUp(UINT nFlags, CPoint point) 
{
	
	CWnd::OnLButtonUp(nFlags, point);
}


BOOL CChartWnd::OnEraseBkgnd(CDC* /*pDC*/) 
{
    return TRUE;    // Don't erase the background.
}

#ifndef _WIN32_WCE
// If system colours change, then redo colours
void CChartWnd::OnSysColorChange() 
{
    CWnd::OnSysColorChange();

#if 0    
    if (GetTextColor() == m_crWindowText)                   // Still using system colours
        SetTextColor(::GetSysColor(COLOR_WINDOWTEXT));      // set to new system colour
    if (GetTextBkColor() == m_crWindowColour)
        SetTextBkColor(::GetSysColor(COLOR_WINDOW));
    if (GetBkColor() == m_crShadow)
        SetBkColor(::GetSysColor(COLOR_3DSHADOW));
    if (GetFixedTextColor() == m_crWindowText)
        SetFixedTextColor(::GetSysColor(COLOR_WINDOWTEXT));
    if (GetFixedBkColor() == m_cr3DFace)
        SetFixedBkColor(::GetSysColor(COLOR_3DFACE));
#endif

    m_crWindowText   = ::GetSysColor(COLOR_WINDOWTEXT);
    m_crWindowColour = ::GetSysColor(COLOR_WINDOW);
    m_cr3DFace       = ::GetSysColor(COLOR_3DFACE);
    m_crShadow       = ::GetSysColor(COLOR_3DSHADOW);

}
#endif

/*********************************************************
 *
 *
 *
 *********************************************************/
void CChartWnd::OnLButtonDown(UINT nFlags, CPoint point) 
{
	// TODO: Add your message handler code here and/or call default
	CWnd::OnLButtonDown(nFlags, point);
}

void CChartWnd::OnRButtonDown(UINT nFlags, CPoint point) 
{
	// TODO: Add your message handler code here and/or call default
	CWnd::OnRButtonDown(nFlags, point);
}

BOOL CChartWnd::DrawChart(CDC* pDC, int index,BOOL bEraseBk/*=FALSE*/)
{
#if 0
	return true;
#endif

	int	i           = index;
    int value       = GetItemValue(index);
    COLORREF color   = GetItemColor(index);
	CRect rect;

    if(m_bDirection == CHART_HORZ)
    {
	    int leftx	= m_nUserNameWidth + LEFT_MARGIN;
	    rect.SetRect(leftx +1,
				    m_nRulerHeight+ i*m_nNormalHeight+4,
				    leftx + (int)((value - m_MiniValue) * m_HorzRatio),
				    (i+1)*m_nNormalHeight+m_nRulerHeight-4);

         DrawColorCube(pDC,rect, color,RGB(255,255,255),true);
    }
    else
    {
        CRect client;
        GetClientRect(&client);
		rect.SetRect(LEFT_MARGIN + m_nRulerLeftWidth +  index*( m_nNormalHeight+8)+8, 
            client.bottom -  m_nNormalHeight - 2*LEFT_MARGIN -(int)((value - m_MiniValue) * m_VertRatio), 
            LEFT_MARGIN + m_nRulerLeftWidth +  (index  +1)* (m_nNormalHeight+8) -8, 
			client.bottom -  m_nNormalHeight - 2*LEFT_MARGIN );

         DrawColorCube(pDC,rect, color,RGB(255,255,255),false);
    }


	return true;
}

/****************************************************************************
 *
 *      Public functions called from outside to change the attributes
 *
 ****************************************************************************/
BOOL CChartWnd::SetChartFromToValue(float from, float to , int ValueStep /*=4*/)
{
    m_MiniValue = (float)from;
    m_MaxiValue = (float)to;

    if(to<=from)
    {
        TRACE("From Value >= To Value, Cannot create Chart!\n");
        return false;
    }

    m_nValueStep = ValueStep ;

    return true;
}

BOOL CChartWnd::AddChartItem(CString user, int value, COLORREF color,int iconIndex /*= -1*/)
{
    int index = m_MemberArray.Add(new CChartItemInfo(user,value,color,iconIndex));
	if(index <0)
        return false;

    if(m_nMaxiUserNameIndex <=0)
    {
        m_nMaxiUserNameIndex = index;
        return true;
    }

    if(GetUserName(m_nMaxiUserNameIndex).GetLength() < user.GetLength())
        m_nMaxiUserNameIndex  = index;

    return true;
}

void CChartWnd::SetChartItem(int index, int value)
{
    CChartItemInfo* zone = (CChartItemInfo*)m_MemberArray.GetAt(index);

    if ( zone )
    {
        zone->SetValue(value);
    }
}

BOOL CChartWnd::RemoveChartItem(int index)
{
    m_MemberArray.RemoveAt(index);
    return true;
}

BOOL CChartWnd::SetUserColTitle(CString title)
{
    m_strUserColTitle = title;
    return true;
}

void CChartWnd::SetChartVert()
{ 
    m_bDirection = CHART_VERT;  
    
}

void CChartWnd::SetChartHorz()
{ 
    m_bDirection = CHART_HORZ;        

#ifndef GRIDCONTROL_NO_TITLETIPS
    m_TitleTip.Hide();
#endif
}


/*********************************************************************
 *
 *	Called from Outside
 *
*********************************************************************/
BOOL CChartWnd::Initialize()
{
	CImageList* ImageList = new CImageList();

    /*
     *  Load ImageList, the image should be Width = Height,
     *   22 is the Width, RGB(192,192,192) is the Transparent color;
     */
//    ImageList->Create(MAKEINTRESOURCE(IDB_BITMAP_2), 22, 1, RGB(192,192,192));
//	SetImageList(ImageList);

    /*
     *  Before add items , you should set the Chart from and to value,
     *  Default :   m_MiniValue = 0;
     *              m_MaxiValue = 100;
     *              m_nValueStep = 4;
     *
     */
    SetChartFromToValue(0,100,4);

    /* 
     * Add  some items 
     * The Value of :
     *      UserName
     *      ItemValue
     *      ItemColor
     *      ItemIcon
     */
	AddChartItem("0Windows",30,tmpColor[0],3);
	AddChartItem("1Printable",25,tmpColor[1],1);
	AddChartItem("2TestingManager",0,tmpColor[2],3);
	AddChartItem("3Prisdkjlsntable",75,tmpColor[3],2);
	AddChartItem("4TestingMasdfsdjnager",5,tmpColor[4],6);
	AddChartItem("5Printablwewfewe",45,tmpColor[5]);
	AddChartItem("6Help me",100,tmpColor[6]);
	AddChartItem("7where are you",88,tmpColor[7]);
	AddChartItem("8TestingMasd",17,tmpColor[0]);
	AddChartItem("9Priewe",5,tmpColor[1]);
	AddChartItem("10Priewe",55,tmpColor[2]);
	AddChartItem("11Priewe",23,tmpColor[3],3);
	AddChartItem("12Priewe",41,tmpColor[4],2);
	AddChartItem("13Priewe",88,tmpColor[5],5);
	AddChartItem("14Priewe",73,tmpColor[6],1);
	AddChartItem("15Priewe",66,tmpColor[7],3);
	AddChartItem("16Priewe",44,tmpColor[0],0);
	AddChartItem("17Priewe",14,tmpColor[1]);
	AddChartItem("18Priewe",67,tmpColor[5]);

    /*
     * If you want, you can also call next functions
     */
#if 0

    BOOL            GetEdgeState()                      { return m_bDrawSunkenEdge;         }
    void            SetEdgeState(BOOL has)              { m_bDrawSunkenEdge = has;          }  

    BOOL            GetUserNameBackState()              { return m_bUserNameBack;           }
    void            SetUserNameBackState(BOOL st)       { m_bUserNameBack = st;             }

    BOOL            GetDisplayState()                   {  return m_bDisplayIcon;           }
    void            SetDisplayState(BOOL st)            {  m_bDisplayIcon = st;             }

    void            SetChartVert();
    void            SetChartHorz();
    BOOL            GetChartDirection()                 { return m_bDirection;              }

	void			SetImageList(CImageList* pList)     { m_pImageList = pList;             }
    CImageList*		GetImageList() const                { return m_pImageList;              }

    int             GetChartItemCount()                 { return m_MemberArray.GetSize();}
    CString         GetUserColTitle()                   { return m_strUserColTitle;         }
    BOOL            SetUserColTitle(CString title);
    void            SetNoBackColor()                    { m_HasBackColor   = false;         }

    BOOL            AddChartItem(CString user, int value, COLORREF color,int iconIndex = -1);
    BOOL            RemoveChartItem(int index);

    void            SetGridLines(int nWhichLines = 0) { m_nGridLines = nWhichLines;       } 
    int             GetGridLines() const              { return m_nGridLines;              }

    void     SetGridColor(COLORREF clr)               { m_crGridColour = clr;             }
    COLORREF GetGridColor() const                     { return m_crGridColour;            }

#endif
    /*
     *  Any other time you've changed the value of the  attributes, if you want the 
     *  Chart Window to refresh, you should call the function 
     *   void            RefreshWindow();
     *  yourself !!!
     */

    /*
     *  Enable Title Tips when vertical;
     */
    EnableTitleTips();

    SetTimer(TIMER_ID,5000,NULL);
    /*
     *  Don't forget to call next function, 
     *  We should calculate  some values before we paint;
     */
    return ReCalculating();
}

BOOL CChartWnd::ReCalculating()
{
	m_nRows = m_MemberArray.GetSize()+1;

    if(m_nRows <=1)
    {
        TRACE("No  Chart item exists.\n");
        return true;
    }

	CString str = GetUserName(m_nMaxiUserNameIndex);

	/* find the width needed for the first row */
	CClientDC dc(this);
	CRect drawRect;
    CSize size;

	drawRect.SetRect(0,0,0,0);
	size  = dc.GetTextExtent(str);
	if(size.cy> (int)m_nNormalHeight)
		m_nNormalHeight	=	size.cy;

	m_nUserNameWidth	= size.cx + LEFT_MARGIN;

    /* calculate  the ruler width */
    str.Format("%f", m_MaxiValue);
	size  = dc.GetTextExtent(str);
	if(size.cy> (int)m_nRulerLeftWidth)
		m_nRulerLeftWidth	=	size.cx + 10; 

    CRect client;
    GetClientRect(&client);
    int width   = client.Width() - m_nUserNameWidth - RIGHT_MARGIN - LEFT_MARGIN;
    m_HorzRatio = (float)width/(float)(m_MaxiValue - m_MiniValue);

    int height  = client.Height() - m_nNormalHeight - TOP_MARGIN - 2*LEFT_MARGIN;
    m_VertRatio = (float)height/(float)(m_MaxiValue - m_MiniValue);

    /* Get Normal Size*/
    IMAGEINFO Info;
    if(m_pImageList)
    {
        int total	= m_pImageList->GetImageCount();
		if(total >0)
		{
            m_pImageList->GetImageInfo(0, &Info);
		    ULONG nImageWidth = Info.rcImage.right-Info.rcImage.left;
            if(nImageWidth > m_nNormalHeight+2)
                m_nNormalHeight = nImageWidth -2;
        }
    }
    return true;
}

static int times  = 0;
static int minute = 0;
void CChartWnd::OnTimer(UINT nID)
{
    times  ++;

	//m_bDirection  = !m_bDirection;

    if(times % 120 ==0)
    {
        TRACE("10 Minutes passed  !  It's OK!\n");
        if(times % 720  ==0)
        {
            TRACE("An hour passed !\n");
            times =0;
        }
    }

    ChangeItemToRandomValue();
    RefreshWindow();
}

void CChartWnd::ChangeItemToRandomValue()
{
    int value;
    for(int i=0; i< m_MemberArray.GetSize(); i++)
    {
        value = m_MiniValue + rand()%(int)(m_MaxiValue-m_MiniValue);
        SetChartItem(i,value);
    }
}

void CChartWnd::OnClose()
{
    KillTimer(TIMER_ID);
}