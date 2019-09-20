update settings set hometext =
    E'<h1>Welcome to OzTrack</h1>\n' ||
    E'<p>\n' ||
    E'    OzTrack is a free-to-use web-based platform for the analysis and \n' ||
    E'    visualisation of animal tracking data. It was developed for the Australian \n' ||
    E'    animal tracking community but can be used to determine, measure and plot \n' ||
    E'    home-ranges for animals anywhere in the world.\n' ||
    E'</p>'
where hometext is null or hometext = '';

update settings set abouttext =
    E'<p>\n' ||
    E'    The present OzTrack project is seeking support from the\n' ||
    E'    <a href="https://www.nectar.org.au/eresearch-tools">NeCTAR e-Research Tools</a>\n' ||
    E'    program for 2012-2013. The NeCTAR OzTrack project will build upon the work\n' ||
    E'    which was completed in the initial\n' ||
    E'    <a href="http://itee.uq.edu.au/~eresearch/projects/ands/oztrack/">OzTrack</a>\n' ||
    E'    project which was supported by the Australian National Data Service (ANDS)\n' ||
    E'    during 2010-2011.\n' ||
    E'</p>\n' ||
    E'<p><b>People involved in the NeCTAR OzTrack project are:</b></p>\n' ||
    E'<p>Project Steering Committee</p>\n' ||
    E'<ul>\n' ||
    E'    <li>Scientific Leader and Chair - Professor Craig Franklin, UQ;</li>\n' ||
    E'    <li>Technical Project Leader &ndash; Professor Jane Hunter, UQ;</li>\n' ||
    E'    <li>Project Manager &ndash; Wilfred Brimblecombe, UQ</li>\n' ||
    E'    <li>Dr Hamish Campbell, UQ</li>\n' ||
    E'    <li>Dr Colin Simpfendorfer, JCU</li>\n' ||
    E'    <li>Dr Toby Patterson, CSIRO</li>\n' ||
    E'    <li>Dr Greg Baxter, UQ</li>\n' ||
    E'    <li>Prof Mark Hindell, UTAS</li>\n' ||
    E'    <li>Dr David Westcott, CSIRO</li>\n' ||
    E'    <li>Prof Stuart Phinn</li>\n' ||
    E'    <li>NeCTAR representative</li>\n' ||
    E'</ul>\n' ||
    E'<p>Project Team</p>\n' ||
    E'<ul>\n' ||
    E'    <li>Project Manager &ndash; Wilfred Brimblecombe, UQ</li>\n' ||
    E'    <li>Scientific Data Analyst &ndash; Dr Ross Dwyer, UQ</li>\n' ||
    E'    <li>Software Engineer &ndash; Charles Brooking, UQ</li>\n' ||
    E'    <li>Independent testers from user community</li>\n' ||
    E'</ul>'
where abouttext is null or abouttext = '';

update settings set contacttext =
    E'<h1> Contacts</h1>\n' ||
    E'<p> For general information about the ZoaTrack project, please see the <a href="about">About ZoaTrack</a> page.</p>\n' ||
    E'<h2> Technical support</h2>\n' ||
    E'<p> For technical support or to report an issue with the website, email <a href="mailto:mathieu.blanchet@biol.lu.se">mathieu.blanchet@biol.lu.se</a>.</p>\n' ||
    E'<h2>BioAtlas.se<h2>\n' ||
    E'<p>You can contact the <a href ="https://bioatlas.se/contact/" target="_blank">BioAtlas team here</a></p> \n' ||
    E'<h2>Related Websites</h2>\n' ||
    E'<p>\n' ||
    E'<a type="button" target="_blank" class="btn searchButton" title="Center for Animal Movement Research" href='https://www.canmove.lu.se/canmov    E'" >\n' ||
    E'<img src="/img/logos/CAnMove.gif" />\n' ||
    E'</a>&nbsp;\n' ||
    E'<a type="button" target="_blank" class="btn searchButton" title="Wireless Remote Animal Monitoring" href='https://www.slu.se/centrumbildningar-och-projekt/wireless-remote-animal-monitoring-wram/Background/'" >\n' ||
    E'<img src="/img/logos/wram.jpg" />\n' ||
    E'</a>&nbsp;\n' ||
    E'<a type="button" target="_blank" class="btn searchButton" title="Movebank" href='https://www.movebank.org/node/2'" >\n' ||
    E'<img src="/img/logos/movebank.png" />\n' ||
    E'</a>\n' ||
    E'</p>\n'
where contacttext is null or contacttext = '';