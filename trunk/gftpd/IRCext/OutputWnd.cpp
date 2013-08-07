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


#include "stdafx.h"			// Precompiled Header
#include "OutputWnd.h"		// class TOutputWnd


#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

TOutputWnd::TOutputWnd()
{
	TRACE0( "CONSTRUCTOR : TOutputWnd()\n" );
	m_pFont = NULL;
	m_BackCol = GetSysColor( COLOR_WINDOW );
	m_nHead = -1;
	m_nLinesDone = 0;
	m_nDefTextCol = COLOUR_BLACK;
	m_bWordWrap = true;
	m_nXOffset = 0;
	m_nMaxLines = 500;		// Maximum of 500 entries ( default )
	m_nMaxWidth = 0;		// Greatest width done
	m_nFontHeight = 0;		// No Font Height


	// Temporary...


	m_ColTable[ COLOUR_WHITE ]		= RGB( 255, 255, 255 );
	m_ColTable[ COLOUR_BLACK ]		= RGB( 0, 0, 0 );
	m_ColTable[ COLOUR_BLUE ]		= RGB( 0, 0, 128 );
	m_ColTable[ COLOUR_GREEN ]		= RGB( 0, 128, 0 );
	m_ColTable[ COLOUR_LIGHTRED ]	= RGB( 255, 0, 0 );
	m_ColTable[ COLOUR_BROWN ]		= RGB( 128, 0, 0 );
	m_ColTable[ COLOUR_PURPLE ]		= RGB( 128, 0, 128 );
	m_ColTable[ COLOUR_ORANGE ]		= RGB( 128, 128, 0 );
	m_ColTable[ COLOUR_YELLOW ]		= RGB( 255, 255, 0 );
	m_ColTable[ COLOUR_LIGHTGREEN ]	= RGB( 0, 255, 0 );
	m_ColTable[ COLOUR_CYAN ]		= RGB( 0, 128, 128 );
	m_ColTable[ COLOUR_LIGHTCYAN ]	= RGB( 0, 255, 255 );
	m_ColTable[ COLOUR_LIGHTBLUE ]	= RGB( 0, 0, 255 );
	m_ColTable[ COLOUR_PINK ]		= RGB( 255, 0, 255 );
	m_ColTable[ COLOUR_GREY ]		= RGB( 128, 128, 128 );
	m_ColTable[ COLOUR_LIGHTGREY ]	= RGB( 192, 192, 192 );


	// -------------------------------------------------------------
	// Load the Cursor:
	// -------------------------------------------------------------


	m_hCursor = AfxGetApp()->LoadStandardCursor( IDC_IBEAM );
}


TOutputWnd::~TOutputWnd()
{
	TRACE0( "DESTRUCTOR : ~TOutputWnd()\n" );


	// Destroy the font we were using:


	if( m_pFont != NULL )
		delete( m_pFont );
}


/*
	=================================================================================
	void TOutputWnd::UpdateHScroll()
	void TOutputWnd::UpdateVScroll()
	--------------------------------

	Updates scroll-bar information.
	=================================================================================
*/


void TOutputWnd::UpdateHScroll()
{
	if( m_bWordWrap ) return;	// No need for word-wrapped output windows
	CRect clientRc; GetClientRect( &clientRc );
	int nMax = m_nMaxWidth - clientRc.Width();
	if( nMax <= 0 )
		m_nXOffset = 0;
	SetScrollRange( SB_HORZ, 0, nMax );
	//SCROLLINFO si;
	//si.fMask = SIF_PAGE;
	//si.nPage = m_nAvgCharWidth;
	//SetScrollInfo( SB_HORZ, &si );
};


void TOutputWnd::UpdateVScroll()
{
	SetScrollRange( SB_VERT, 0, GetLineCount() - 1 );
	//SCROLLINFO si;
	//si.fMask = SIF_PAGE;
	//si.nPage = GetMaxViewableLines();
	//SetScrollInfo( SB_VERT, &si );
};

	
void TOutputWnd::RenderSingleLine( CString& strLine,
								   CDC* pDC,
								   int nX,
								   int nY )
{
	CRect clientRc; GetClientRect( &clientRc );
	CString strTemp = strLine;
	CString strToRender;
	SIZE sz;
	int nPos;
	UINT nWidth = 0;
	do
	{
		nPos = strTemp.Find( CONTROL_BYTE );
		if( nPos > -1 )
		{
			strToRender = strTemp.Left( nPos );
			if( strToRender != "" )
			{
				if( !FLAG( m_lfFont.lfPitchAndFamily, FIXED_PITCH ) )
					::GetTextExtentPoint32( pDC->GetSafeHdc(), strToRender, strToRender.GetLength(), &sz );
				else
					sz.cx = strToRender.GetLength() * m_nAvgCharWidth;

				pDC->TextOut( nX, nY, strToRender );
				nX += sz.cx;
				nWidth += sz.cx;
			};
			COLOURCODE code;
			strTemp = strTemp.Mid( nPos );
			GetColourCodes( strTemp, &code );
			if( code.nFore != -1 ) pDC->SetTextColor( m_ColTable[ code.nFore ] );
			if( code.nBack != -1 ) pDC->SetBkColor( m_ColTable[ code.nBack ] );
		}
		else
		{
			if( !FLAG( m_lfFont.lfPitchAndFamily, FIXED_PITCH ) )
				::GetTextExtentPoint32( pDC->GetSafeHdc(), strTemp, strTemp.GetLength(), &sz );
			else
				sz.cx = strTemp.GetLength() * m_nAvgCharWidth;
			nWidth += sz.cx;
			pDC->TextOut( nX, nY, strTemp );
			nX += sz.cx;


			// Pad out rest of line with solid colour:


			CRect solidRc( nX, nY, clientRc.right, nY + m_nFontHeight );
			pDC->FillSolidRect( &solidRc, m_BackCol );
			break;
		}
	}while( 1 );
	nY += m_nFontHeight;


	// -------------------------------------------------------------
	// Update Horizontal scroll bar for width ( for times when the
	// word wrap is OFF )
	// -------------------------------------------------------------


	if( nWidth > m_nMaxWidth && !m_bWordWrap )
	{
		m_nMaxWidth = nWidth;
		UpdateHScroll();
	};
};


/*
	=================================================================================
	int TOutputWnd::GetLineInfo( CString&, LINEINFO* )
	--------------------------------------------------

	Works out the bounding rectangle of a line, and fills out a 
	LINERECT with the necessary information to render it.  This 
	function will automatically strip out control codes for the
	purpose of measuring.
	=================================================================================
*/


int TOutputWnd::GetLineInfo( CString& strLine,
							 CDC* pDC,
							 int nRight )
{
	int nLines = 1;				// Start of with 1 line


	// ---------------------------------------------------------
	// We can very quickly handle empty lines:
	// ---------------------------------------------------------


	if( strLine == "" )
		return( nLines );		// See, I told u it was easy.


	// And lets do the rest properly:


	int nLen = strLine.GetLength();
	int nOriginalLength = nLen;
	char* pTmp = new char[ nOriginalLength + 1 ];
	char ch = 0;
	SIZE sz;
	memset( pTmp, 0, nOriginalLength );
	int nCurrWidth = 0;			// Width of current line
	int nPosInTemp = 0;			// Current Position in temp buffer
	int nPosInString = 0;		// Current Position in string
	int nSpc = 0;
	HDC hDC = pDC->GetSafeHdc();// Handle to the device context
	CString strLeftPart;		// Left Part
	CString strRightPart;		// Right Part
	int nLastWrap = -1;			// Where we put the last wrap point
	COLOURCODE code;
	do
	{
		ch = strLine[ nPosInString ];
		if( ch != CONTROL_BYTE )
		{
			pTmp[ nPosInTemp ] = ch;
			if( !FLAG( m_lfFont.lfPitchAndFamily, FIXED_PITCH ) )
				::GetTextExtentPoint32( hDC, pTmp, nPosInTemp + 1, &sz );
			else
				sz.cx = ( nPosInTemp + 1 ) * m_nAvgCharWidth;

			if( sz.cx >= nRight )
			{
				// Find the previous space


				for( int nSpc = nPosInString - 1; nSpc >= 0; nSpc -- )
					if( strLine[ nSpc ] == ' ' ) break;

				if( nSpc == 0 )
					nSpc = nPosInString;

				if( nSpc > nLastWrap )
				{
					strLeftPart = strLine.Left( nSpc );
					strRightPart = strLine.Mid( nSpc + 1 );
					strLine = strLine.Left( nSpc );
					nLastWrap = nSpc;
					strLine += WRAP_BYTE;
					strLine += strRightPart;
					nPosInString = nSpc + 1;
					nLen = strLine.GetLength();
					nLines++;		// And another line
				};

				memset( pTmp, 0, nOriginalLength );
				nPosInTemp = 0;
			}
			else
			{
				nPosInTemp++;
				nPosInString++;
			};
		}
		else
		{
			CString strTemp = strLine.Mid( nPosInString );	// Make temp copy. dont want to modify original
			nPosInString += GetColourCodes( strTemp, &code );// skips correct number of bytes
		};

	}while( nPosInString < nLen );
	delete [] pTmp;
	return( nLines );
};


/*
	=================================================================
	int TOutputWnd::GetColourCodes( CString&, COLOURCODE* )
	-------------------------------------------------------

	Looks at the data passed ( first character must be the control
	byte ), and fills in the COLOURCODE structure accordingly.  This
	function returns the number of bytes to skip.
	=================================================================
*/


int TOutputWnd::GetColourCodes( CString& strData, 
							    COLOURCODE* pColourCode )
{
	ASSERT( pColourCode != NULL );
	ASSERT( strData.Left( 1 ) == CONTROL_BYTE );
	strData = strData.Mid( 1 );	// Truncate control byte
	int nBytesToSkip = 1;


	// Jump out of strData is now empty...


	if( strData == "" )
	{
		pColourCode->nFore = -1;	// No foreground colour
		pColourCode->nBack = -1;	// No background colour
	}
	else
	{

		// Now handle foreground and background colours:


		int nComma = strData.Find( "," );		// Position of comma.  Only present if background colour present
		if( ( nComma != -1 ) &&
			( ( nComma == 1 ) ||
			  ( nComma == 2 && isdigit( strData[ 1 ] ) ) 
			)
		  )
		{
			CString strFore = strData.Left( nComma );
			nBytesToSkip += strFore.GetLength() + 1;	// Includes code and comma
			pColourCode->nFore = atoi( strFore );		// Get Code
			strData = strData.Mid( nComma + 1 );		// Truncate string


			// Now look for backcolour:


			CString strBack;
			int nCodeLength = 1;
			if( strData.GetLength() >= 2 )
			{
				if( isdigit( strData[ 1 ] ) )
					nCodeLength++;
			};

			nBytesToSkip+= nCodeLength;
			strBack = strData.Left( nCodeLength );
			strData = strData.Mid( nCodeLength );
			pColourCode->nBack = atoi( strBack );
		}
		else
		{
			// No background colour present, the delimiter for this code
			// is the next non-numeric character...


			CString strFore;
			int nCodeLength = 1;
			if( strData.GetLength() >= 2 )
			{
				if( isdigit( strData[ 1 ] ) )
					nCodeLength++;
			};

			nBytesToSkip += nCodeLength;
			strFore = strData.Left( nCodeLength );
			strData = strData.Mid( nCodeLength );
			pColourCode->nFore = atoi( strFore );
			pColourCode->nBack = -1;
		};
	};


	// Return number of bytes processed:


	return( nBytesToSkip );
};


/*
	=================================================================
	void TOutputWnd::SetBuffer( CStringArray& )
	bool TOutputWnd::GetBuffer( CStringArray& ) const
	-------------------------------------------------

	Sets or gets the content of the buffer.  This facility allows a
	different part of the application to use multiple buffers with
	one output window.  A typical example of this kind of use is the
	RAW output window which uses one output window, but allows the
	user to switch the content.
	=================================================================
*/


void TOutputWnd::SetBuffer( CStringArray& rArray )
{
	// Copy the buffer across:


	m_Lines.RemoveAll();
	int nLines = rArray.GetUpperBound() + 1;
	for( int l = 0; l < nLines; l ++ )
		m_Lines.Add( rArray.GetAt( l ) );


	UpdateVScroll();


	// Place the head at the bottom.


	m_nHead = nLines - 1;


	// Redraw the view if necessary:


	if( GetSafeHwnd() )
	{
		Invalidate();
		UpdateHScroll();
	};
};


bool TOutputWnd::GetBuffer( CStringArray& rArray ) const
{
	rArray.RemoveAll();		// Ensures the passed array is empty


	// -------------------------------------------------------------
	// Add the lines to the buffer that was passed:
	// -------------------------------------------------------------


	int nLines = m_Lines.GetUpperBound() + 1;
	for( int l = 0; l < nLines; l ++ )
		rArray.Add( m_Lines.GetAt( l ) );

	return( true );
};


/*
	=================================================================
	void TOutputWnd::ClearBuffer()
	------------------------------

	Clears the entire buffer of content.
	=================================================================
*/


void TOutputWnd::ClearBuffer()
{
	m_Lines.RemoveAll();
	m_nMaxWidth = 0;
	m_nHead = -1;
	if( GetSafeHwnd() )
	{
		UpdateHScroll();
		UpdateVScroll();
		Invalidate();
	};
};


/*
	=================================================================
	void TOutputWnd::AddLine( CString& )
	------------------------------------

	Adds a line to the output window.
	=================================================================
*/


void TOutputWnd::AddLine( CString& strLine )
{
	// Add to the buffer, cutting off the first ( top ) line if
	// necessary.


	m_Lines.Add( strLine );
	if( GetLineCount() > m_nMaxLines )
	{
		m_Lines.RemoveAt( 0 );
		m_nHead--;
	};


	// Update the vertical scroll bar:


	UpdateVScroll();


	// Automatically scroll down if the user is already at the
	// bottom...


	if( m_nHead == GetLineCount() - 2 || m_nHead == -1 )
	{
		m_nHead++;
		SetHead( m_nHead );
	}
	else
		Invalidate();
};


/*
	=================================================================
	void TOutputWnd::SetFont( LOGFONT& )
	bool TOutputWnd::GetFont( LOGFONT& ) const
	------------------------------------------

	Sets or returns the font used to render the output text.
	=================================================================
*/


void TOutputWnd::SetFont( LOGFONT& rFont )
{
	// Destroy the old font if necessary:


	if( m_pFont != NULL )
	{
		delete( m_pFont );
		m_pFont = NULL;
	};


	// Create the new one:


	m_pFont = new CFont;
	m_pFont->CreateFontIndirect( &rFont );
	memcpy( &m_lfFont, &rFont, sizeof( LOGFONT ) );


	// Get the Average Char Width:


	TEXTMETRIC tm;
	CDC* pDC = GetDC();
	CFont* pOldFont = pDC->SelectObject( m_pFont );
	pDC->GetTextMetrics( &tm );
	pDC->SelectObject( pOldFont );
	ReleaseDC( pDC );
	m_nAvgCharWidth = tm.tmAveCharWidth;
	m_nFontHeight = tm.tmHeight;


	// Redraw the display if necessary:


	if( GetSafeHwnd() )
	{
		UpdateHScroll();	// Page size depends on average char width
		Invalidate();
	};
};


bool TOutputWnd::GetFont( LOGFONT& rFont ) const
{
	if( m_pFont != NULL )
	{
		memcpy( &rFont, &m_lfFont, sizeof( LOGFONT ) );
		return( true );
	}
	else
		return( false );	// Should never happen unless I'm stupid
};


/*
	=================================================================
	void TOutputWnd::SetBackColour( COLORREF )
	------------------------------------------

	Sets the background colour.
	=================================================================
*/


void TOutputWnd::SetBackColour( COLORREF col )
{
	m_BackCol = col;


	// Force a repaint if we are displayed.


	if( GetSafeHwnd() )
		Invalidate();
};


/*
	=================================================================
	void TOutputWnd::SetHead( int )
	-------------------------------

	Sets the position of the view relative to the first line of the
	buffer.
	=================================================================
*/


void TOutputWnd::SetHead( int nPos )
{
	if( nPos < -1 ) nPos = -1;
	if( nPos > GetLineCount() - 1 ) nPos = GetLineCount() - 1;
	m_nHead = nPos;
	if( GetSafeHwnd() )
	{
		SetScrollPos( SB_VERT, m_nHead );
		Invalidate();
	};
};


/*
	=================================================================
	void TOutputWnd::SetMaxLines( UINT )
	------------------------------------

	Sets the maximum amount of lines we can display.
	=================================================================
*/


void TOutputWnd::SetMaxLines( UINT nLines )
{
};


/*
	=================================================================
	UINT TOutputWnd::GetMaxViewableLines() const
	--------------------------------------------

	Based on the current font, this function returns the maximum 
	number of lines that can be displayed in the output window, given
	it's current size.
	=================================================================
*/


UINT TOutputWnd::GetMaxViewableLines()
{
	ASSERT( GetSafeHwnd() != NULL );	// Must have been created
	CRect clientRc; GetClientRect( &clientRc );
	return( clientRc.Height() / m_nFontHeight );
};


/*
	=================================================================================
	void TOutputWnd::SetWordWrap( bool )
	------------------------------------

	Sets whether we word-wrap or not.
	=================================================================================
*/


void TOutputWnd::SetWordWrap( bool bWrap )
{
	m_bWordWrap = bWrap;
	if( GetSafeHwnd() )
		Invalidate();
};


/*
	=================================================================
	void TOutputWnd::Load( const char* )
	------------------------------------

	Loads a text file in from disk, and puts it in to the buffer.
	=================================================================
*/


void TOutputWnd::Load( const char* lpFilename )
{
	CStringArray tmpArray;	// Temporary Array
	CFile file;
	if( file.Open( lpFilename, CFile::modeRead ) )
	{
		// ---------------------------------------------------------
		// Read the entire file into memory
		// ---------------------------------------------------------

		int nLen = file.GetLength();
		char* pBuffer = new char[ nLen + 1 ];
		file.Read( pBuffer, nLen );
		pBuffer[ nLen ] = 0;
		CString strTemp = pBuffer;
		delete [] pBuffer;
		file.Close();


		// ---------------------------------------------------------
		// Now add it to the buffer, line by line:
		// ---------------------------------------------------------


		int nCRLF = -1;
		do
		{
			if( ( nCRLF = strTemp.Find( "\r\n" ) ) != -1 )
			{
				tmpArray.Add( strTemp.Left( nCRLF ) );
				strTemp = strTemp.Mid( nCRLF + 2 );
			}
			else
			{
				tmpArray.Add( strTemp );
				strTemp = "";
			};
		}while( strTemp != "" );
		SetBuffer( tmpArray );
	};
};


/*
	=================================================================
	TOutputWnd Message Map:
	=================================================================
*/


BEGIN_MESSAGE_MAP( TOutputWnd, CWnd )
	//{{AFX_MSG_MAP(TOutputWnd)
	ON_WM_CREATE()
	ON_WM_DESTROY()
	ON_WM_PAINT()
	ON_WM_ERASEBKGND()
	ON_WM_VSCROLL()
	ON_WM_SIZE()
	ON_WM_HSCROLL()
	ON_WM_SETCURSOR()
	ON_WM_LBUTTONUP()
	ON_WM_RBUTTONDOWN()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()


/*
	=================================================================
	int TOutputWnd::OnCreate( LPCREATESTRUCT )
	------------------------------------------

	Initializes the window members, etc.
	=================================================================
*/


int TOutputWnd::OnCreate( LPCREATESTRUCT lpCreateStruct ) 
{
	// -------------------------------------------------------------
	// Call base-class implementation:
	// -------------------------------------------------------------


	if( CWnd::OnCreate( lpCreateStruct ) == -1 )
		return( -1 );


	// -------------------------------------------------------------
	// Give ourselves the device's default fixed-width font:
	// -------------------------------------------------------------

#ifndef _WINNT
	HFONT hSysFont = ( HFONT )GetStockObject( DEFAULT_GUI_FONT );
#else
	HFONT hSysFont = ( HFONT )GetStockObject( DEVICE_DEFAULT_FONT );
#endif	// !_WINNT

	LOGFONT lf;
	CFont* pFont = CFont::FromHandle( hSysFont );
	pFont->GetLogFont( &lf );
	SetFont( lf );


	// Initialize the scroll bars:


	SetScrollRange( SB_VERT, 0, 0 );
	SetScrollPos( SB_VERT, 0 );
	SetScrollRange( SB_HORZ, 0, 0 );
	SetScrollPos( SB_HORZ, 0 );
	return( 0 );
}


/*
	=================================================================
	void TOutputWnd::OnDestroy()
	----------------------------

	Cleans up anything we allocated during the lifetime of this 
	window ( namely fonts, bitmaps and device contexts )
	=================================================================
*/


void TOutputWnd::OnDestroy() 
{
	// Call base-class implementation:


	CWnd::OnDestroy();


	// TOutputWnd-specific destruction:


};


/*
	=================================================================
	void TOuputWnd::OnPaint()
	-------------------------

	Simply blits our memory DC to the window's DC.
	=================================================================
*/


void TOutputWnd::OnPaint() 
{
	CPaintDC dc( this );
	CRect clientRc; GetClientRect( &clientRc );


	// Initialize the draw:


	UINT nMaxLines = GetMaxViewableLines();					// Max number of lines in view
	m_nLinesDone = 0;										// No Lines drawn


	// Initialize colours and font:
	

	CFont* pOldFont = dc.SelectObject( m_pFont );


	// Now draw the lines, one by one:


	UINT nUBound = m_Lines.GetUpperBound();
	if( m_nHead != -1 )
	{
		int nRunner = m_nHead;
		int nX = clientRc.left - m_nXOffset;
		int nMasterY = clientRc.bottom;
		int nY = nMasterY;
		int nPos = -1;
		CString strTemp;
		CString strLine;
		do
		{
			// -----------------------------------------------------
			// Reset Colours:
			// -----------------------------------------------------


			dc.SetBkColor( m_BackCol );
			dc.SetTextColor( m_ColTable[ m_nDefTextCol ] );


			// -----------------------------------------------------
			// Proceed on to the next line:
			// -----------------------------------------------------


			strTemp = m_Lines[ nRunner ];
			if( !m_bWordWrap )
			{
				// Life is easier if no word-wrapping is expected
				// of us.  ( A damn sight quicker too <g> )


				nMasterY -= m_nFontHeight;
				RenderSingleLine( strTemp, &dc, nX, nMasterY );
			}
			else
			{
				// Obtain the line info for this line.  This 
				// routine will insert word-wrap control byes for
				// proper wrapping.  It returns the number of lines
				// processed.


				nMasterY -= GetLineInfo( strTemp, &dc, clientRc.right ) * m_nFontHeight;
				nY = nMasterY;
				do
				{
					if( ( nPos = strTemp.Find( WRAP_BYTE ) ) != -1 )
					{
						RenderSingleLine( strTemp.Left( nPos ), &dc, nX, nY );
						strTemp = strTemp.Mid( nPos + 1 );
					}
					else
					{
						RenderSingleLine( strTemp, &dc, nX, nY );
						strTemp = "";
					};
					nY += m_nFontHeight;
				}while( strTemp != "" );
			};


			// -----------------------------------------------------
			// Go on to the next line.
			// -----------------------------------------------------


			nRunner--;
		}while( nRunner > -1 && nMasterY >= 0 );


		// Pad out any remaining area...


		if( nMasterY >= 0 )
		{
			CRect solidRc = clientRc;
			solidRc.bottom = nMasterY;
			dc.FillSolidRect( &solidRc, m_BackCol );
		};
	}
	else
		dc.FillSolidRect( &clientRc, m_BackCol );


	// Clean up:


	dc.SelectObject( pOldFont );
}


/*
	=================================================================
	BOOL TOutputWnd::OnEraseBkgnd( CDC* )
	-------------------------------------

	Simply returns TRUE as we don't use this function and we don't
	want a flicker.
	=================================================================
*/


BOOL TOutputWnd::OnEraseBkgnd( CDC* pDC ) 
{
	return( TRUE );
}


/*
	=================================================================
	void TOutputWnd::OnVScroll( UINT, UINT, CScrollBar* )
	-----------------------------------------------------

	Occurs when the user scrolls.  Our job here is to position the
	head.
	=================================================================
*/


void TOutputWnd::OnVScroll( UINT nSBCode, 
						    UINT nPos, 
							CScrollBar* pScrollBar ) 
{
	int nUBound = GetLineCount() - 1;
	switch( nSBCode )
	{
	case SB_TOP:
		SetHead( 0 );
		break;

	case SB_BOTTOM:
		SetHead( nUBound );
		break;

	case SB_PAGEUP:
	case SB_LINEUP:
		if( m_nHead > 0 )
		{
			m_nHead--;
			SetHead( m_nHead );
		}
		break;

	case SB_PAGEDOWN:
	case SB_LINEDOWN:
		if( m_nHead < nUBound )
		{
			m_nHead++;
			SetHead( m_nHead );
		};
		break;

	case SB_THUMBPOSITION:
	case SB_THUMBTRACK:
		SetHead( ( int )nPos );
		break;
	};
	CWnd::OnVScroll( nSBCode, nPos, pScrollBar );
}


/*
	=================================================================
	void TOutputWnd::OnHScroll( UINT, UINT, CScrollBar* )
	-----------------------------------------------------

	For Non-Wordwrapped output windows, the horizontal scroll bar
	can adjust the viewport so the user can see the end of the line.
	=================================================================
*/


void TOutputWnd::OnHScroll( UINT nSBCode, 
						    UINT nPos, 
							CScrollBar* pScrollBar ) 
{
	CRect clientRc; GetClientRect( &clientRc );
	UINT nMax = m_nMaxWidth - clientRc.Width();
	switch( nSBCode )
	{
	case SB_TOP:
		m_nXOffset = 0;
		break;

	case SB_BOTTOM:
		m_nXOffset = nMax;
		break;

	case SB_LINEUP:
	case SB_PAGEUP:
		{
			m_nXOffset -= m_nAvgCharWidth;
			if( m_nXOffset < 0 ) m_nXOffset = 0;
			break;
		};

	case SB_LINEDOWN:
	case SB_PAGEDOWN:
		{
			m_nXOffset += m_nAvgCharWidth;
			if( m_nXOffset > nMax ) m_nXOffset = nMax;
			break;
		};

	case SB_THUMBPOSITION:
	case SB_THUMBTRACK:
		m_nXOffset = ( int )nPos;
		break;
	};
	SetScrollPos( SB_HORZ, m_nXOffset );
	Invalidate();
	CWnd::OnHScroll( nSBCode, nPos, pScrollBar );
}


/*
	=================================================================================
	void TOutputWnd::OnSize( UINT, int, int )
	-----------------------------------------

	Overidden to update the scroll bars.
	=================================================================================
*/


void TOutputWnd::OnSize(UINT nType, int cx, int cy) 
{
	CWnd ::OnSize(nType, cx, cy);
	if( GetSafeHwnd() )
	{
		UpdateHScroll();
		UpdateVScroll();
	};
}


/*
	=================================================================
	BOOL TOuputWnd::OnSetCursor( CWnd*, UINT, UINT )
	------------------------------------------------

	Overidden to set the window cursor.
	=================================================================
*/


BOOL TOutputWnd::OnSetCursor( CWnd* pWnd, 
							  UINT nHitTest, 
							  UINT message ) 
{
	if( nHitTest != HTVSCROLL &&
		nHitTest != HTHSCROLL )
	{
		SetCursor( m_hCursor );
		return( TRUE );
	}
	else
		return( CWnd::OnSetCursor( pWnd, nHitTest, message ) );
}


/*
	=================================================================================
	Mouse handlers:
	=================================================================================
*/


void TOutputWnd::OnLButtonUp( UINT nFlags, CPoint point ) 
{
	// *** Put code for notifying owner about button up ***
	CWnd::OnLButtonUp( nFlags, point );
}


void TOutputWnd::OnRButtonDown( UINT nFlags, CPoint point ) 
{
	// *** Put code for notifying owner about Rbutton down ***
	CWnd::OnRButtonDown( nFlags, point );
}
