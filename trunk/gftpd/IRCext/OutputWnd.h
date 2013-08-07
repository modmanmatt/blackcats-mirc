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


#pragma once


#ifndef FLAG
#define FLAG( a,b )		( ( a & b ) == b )
#endif	// FLAG


// -----------------------------------------------------------------
// Control:
// -----------------------------------------------------------------


#define		CONTROL_BYTE		 3			// Control Character
#define		WRAP_BYTE			30			// Word-wrap byte


// -----------------------------------------------------------------
// Colour Code Structure.
// -----------------------------------------------------------------


typedef struct _tagCOLOURCODE
{
	UINT nFore;		// Foreground Colour Index
	UINT nBack;		// Background Colour Index
} COLOURCODE;


// -----------------------------------------------------------------
// Colour Codes:
// -----------------------------------------------------------------


#define COLOUR_WHITE		0
#define COLOUR_BLACK		1
#define COLOUR_BLUE			2
#define COLOUR_GREEN		3
#define COLOUR_LIGHTRED		4
#define COLOUR_BROWN		5
#define COLOUR_PURPLE		6
#define COLOUR_ORANGE		7
#define COLOUR_YELLOW		8
#define COLOUR_LIGHTGREEN	9
#define COLOUR_CYAN			10
#define COLOUR_LIGHTCYAN	11
#define COLOUR_LIGHTBLUE	12
#define COLOUR_PINK			13
#define COLOUR_GREY			14
#define COLOUR_LIGHTGREY	15


// -----------------------------------------------------------------
// class TOutputWnd
// -----------------------------------------------------------------


class TOutputWnd : public CWnd
{
private:

	CFont*			m_pFont;			// Font we are using
	LOGFONT			m_lfFont;			// Font as a LOGFONT
	COLORREF		m_BackCol;			// Background Colour
	CStringArray	m_Lines;			// Lines
	int				m_nHead;			// Head of the buffer
	UINT			m_nMaxLines;		// Maximum buffer size
	UINT			m_nDefTextCol;		// Default Text Colour Index
	UINT			m_nXOffset;			// X Offset for drawing
	UINT			m_nMaxWidth;		// Maximum Written so far
	UINT			m_nAvgCharWidth;	// Average Char Width
	bool			m_bWordWrap;		// Word wrapping?
	HCURSOR			m_hCursor;			// Cursor for the window
	UINT			m_nFontHeight;		// Height of the font
	COLORREF		m_ColTable[ 16 ];	// Colour Table


	// Really internal shit:


	UINT			m_nLinesDone;		// Actual number of lines we drew last-time


	// Update the Vertical/Horizontal scrollbars...


	void UpdateHScroll();
	void UpdateVScroll();


	// Private function to obtain a LINEINFO structure


	int	 GetLineInfo( CString&, CDC*, int );
	void RenderSingleLine( CString&, CDC*, int, int );
	int  GetColourCodes( CString&, COLOURCODE* );		// Remains the same
public:
	TOutputWnd();
	virtual ~TOutputWnd();


	// Operations:


	void SetWordWrap( bool bWrap );		// Set Word-wrapping
	bool GetWordWrap() const { return( m_bWordWrap ); };
	void SetDefaultTextColour( UINT nIndex ) { m_nDefTextCol = nIndex; if( GetSafeHwnd() ) Invalidate(); };	// Set default text colour
	UINT GetDefaultTextColour() const { return( m_nDefTextCol ); };
	void SetBuffer( CStringArray& );	// Set the buffer
	bool GetBuffer( CStringArray& ) const; // Return the buffer
	void AddLine( CString& strLine );	// Add a Line
	void SetFont( LOGFONT& lf );		// Set the Font
	bool GetFont( LOGFONT& lf ) const;	// Return the Font
	void SetBackColour( COLORREF col );	// Set the background Colour
	COLORREF GetBackColour() const { return( m_BackCol ); };// Retrieve the background Colour
	void SetColourTable( COLORREF* pColTable ) { memcpy( &m_ColTable, pColTable, sizeof( COLORREF ) * 16 ); if( GetSafeHwnd() ) Invalidate(); };
	void SetHead( int nHead );			// Set the Head
	int GetHead() const { return( m_nHead ); };	// Return the Head
	void SetMaxLines( UINT nMaxLines );		// Set max number of lines
	UINT GetMaxLines() const { return( m_nMaxLines ); };	// Return max number of lines
	UINT GetMaxViewableLines();	// Return viewable lines
	int GetLineCount() const { return( m_Lines.GetUpperBound() + 1 ); };	// Get Line Count
	CString GetLine( int l ) const { return( m_Lines.GetAt( l ) ); };	// Retrieve a specific line
	void ClearBuffer();			// Clear the buffer
	void Load( const char* lpFilename );	// Load from a file
	void Save( const char* lpFilename );	// Save to a file

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(TOutputWnd)
	//}}AFX_VIRTUAL

	// Generated message map functions
protected:
	//{{AFX_MSG(TOutputWnd)
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnDestroy();
	afx_msg void OnPaint();
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	afx_msg void OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg BOOL OnSetCursor(CWnd* pWnd, UINT nHitTest, UINT message);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnRButtonDown(UINT nFlags, CPoint point);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};
