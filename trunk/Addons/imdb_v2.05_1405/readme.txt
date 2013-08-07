                           _______ ____  ____
                        __|   |   |    `|    `.
                       |__|       |     |   - |
                       |  |       |  -  |   - |
                       |  | |   | |     |     |
                       |__|_|___|_|____.|____.'

 .---------------------/  IMDb MOVIE SEARCH  \----------------------.

     -Info-

    Author..: Meij
    Version.: 2.05
    Email...: meijie@gmail.com

  ------------------------------------------------------------------
     -About-

   This script will enable you and your peer's to search imdb.com
   from the comfort of your own irc channel.

  ------------------------------------------------------------------

     -Instructions-

    1) Unpack zip file where ever you like (preferably in the mIRC
         directory)
    2) Open mIRC.
    3) Type /load -rs c:\path\to\file\imdb.mrc (or similar)
    4) Type /_imdb and setup the script.
    5) All done, enjoy!

  ------------------------------------------------------------------

     -Cookies-

   Control Characters
     &b^               bold
     &u^               underline
     &o^               reset
     &k^               colour
     &r^               invert

   Global
     &chan^            channel the search was started from
     &limit^           limit of results to return
     &nick^            nickname of who started the search
     &search^          the search term

   List
     &num^             result number
     &title^           title / name of the movie or cast / crew
     &url^             the respective url
     &year^            year of release

   Box Office
     &budget^                   movie budget
     &opening_weekend^          opening weekend takings
     &opening_weekend_region^   opening weekend region
     &opening_weekend_date^     opening weekend date
     &opening_weekend_screens^  opening weekend screens
     &gross^                    gross earnings
     &gross_region^             gross region
     &gross_date^               gross date
     &weekend_gross^            weekend gross earnings
     &weekend_gross_region^     weekend gross region
     &weekend_gross_date^       weekend gross date
     &weekend_gross_screens^    weekend gross screens
     &admissions^               total admissions
     &admissions_region^        admissions region
     &admissions_date^          admissions date
     &filming_dates^            filming dates
     &copyright_holder^         copyright holder info

   Cast / Crew
     &alternate_names^  alternative name(s)
     &born^             where and when they were born
     &height^           persons height
     &mini_biography^   little bit about them
     &name^             their name
     &other_works^      other works by the person
     &personal_quote^   a quote of the person
     &star_sign^        the persons star sign
     &trademark^        what the person is known for
     &trivia^           fun fact about the person
     &url^              url

   Movie Info
     &cast^            list of cast
     &color^           what kind of color processing was used
     &country^         country of origin
     &directed_by^     list of directors
     &genre^           list of genre
     &language^        movies language
     &plot_keywords^   plot keywords
     &rating^          numberic rating
     &rating_bar^      bar graph
     &rating_extra^    extra info, eg if the movies in the top 250
     &rating_votes^    how many votes have been cast
     &runtime^         running time of the movie
     &tagline^        tagline
     &trivia^          interesting facts about the movie
     &user_comments^   user comments
     &writing_credits^ list of script writers
     &year^            year of release

   Error
     &error^           description of the error

   Most of these cookies are created dynamicly, so there maybe
   others you can use aswell. That said this will also mean some
   cookies wont work for all search's. As a work around for this
   any line that contains 100% unparsed cookies will be ignored
   (this doesnt include control character cookies).

  ------------------------------------------------------------------

     -Whats New-

   v2.05
     - Lots of cookies have changed names!
     - Fixed parsing errors.

   v2.04
     - Fixed parsing errors.

   v2.03
     - Fixed parsing errors.

   v2.02
     - Fixed parsing errors.

   v2.01
     - No longer requires mIRC 6.17 or newer, but anything older
       will not be supported.
     - Fixed 'country' cookie typeo.
     - Fixed line 236 $iif error.
     - Fixed saving of themes.
     - Fixed re-ordering of themes with 10 or more lines.
     - Fixed a bug when using this script in combination with FiSH.
     - Fixed genre seperators to use forward slashes.
     - Plus some smaller changes not worth listing.

   v2.0
     - Requires mIRC 6.17 or newer now.
     - Recoded & cleaned up large portions of the script.
     - Added the ability to search using imdb urls directly.
       (ie: !imdb http://www.imdb.com/...)
     - Added the option to report results to channel as a notice.
     - Added IMDb dialog icon.
     - Added Box Office/Screens information. This can be displayed
       by either using the '-b' flag or permanently by checking the
       option in the configurations dialog.
     - Added Matching option. The new '-m' flag will toggle between
       exact and popular searching. You can also permanently toggle
       this option in the configuration dialog. The new flag will
       always change the type of search being performed based on
       what configuration option is set.
     - Added 'year' cookie to the movie information.
     - Added extra information to titles (ie: TV series, VG, etc..).
     - Added ability to make cookies return nothing rather than n/a
       (eg: &!opening_weekend_screens^ for example wont display
       anything if we havent got the box office information).
     - Added per-channel flood protection.
     - Fixed director cookie.
     - Changed http Connection header to close.
     - Changed the configuration dialog.
     - Changed the parsing of options. Now uses the format '!trigger
       -bm <search>'. The old format is still supported.
     - Removed old version history.

 `------------------------------------------------------------------'