Alfred Reference Framework
==========================

Framework for Alfred written in Bash which makes it simple to create workflows to search and look up information without leaving the Alfred interface. This gets around the issue caused by the fact that <a href="http://www.alfredforum.com/topic/5-generating-feedback-in-workflows/">"Script Filters are the only way to pass feedback to Alfred"</a>

###### Here's an example of what kind of application can be created with ARF:

<ol>

<li> As with all Alfred Workflows, the user begins by typing in workflow's keyword, in this case, "arf"
<img src="http://www.danieljchen.com/images/project/arf/keyword.png">

<li>The user then types in his/her query, and results are displayed. Again, part of the standard Alfred Workflow.
<img src="http://www.danieljchen.com/images/project/arf/search.png"><br>

Normally at this point, the user will select a result and something <b>outside of Alfred</b> will occur, whether that's bring up a webpage, open/do something in a third-party application, etc. The limitations of the Alfred interface mean that once results for a query are displayed, selection of the results means Alfred is done.<p>

<li>With the Alfred Reference Framework, however, this is not the case. Selection of one of the search results generates a special query which then displays results <b>without having to leave Alfred</b>

<img src="http://www.danieljchen.com/images/project/arf/display.png">

</ol>

A more useful example of a static ARF workflow is the <a href="https://github.com/cheniel/alfred-tea-master">Alfred Tea Master Workflow</a>, which is the code generalized to make ARF. 

ARF makes it easy to make workflows of this type. To create an ARF workflow in static mode, all that is required is modification of <a href="https://github.com/cheniel/alfred-reference-framework/blob/master/arf/data/static.arf">static.arf</a>, which is a '!' delimited plain text file containing the data searched and displayed.

Actively under development, currently functional on static mode. v1.0 will be when arf+ is finished. ARF+ is a library that will allow for the dynamic generation of results that can be searched and displayed. This will allow dynamic information to be retrieved from the web and other sources.

###Future Additions
<ul>
<li> Library to dynamically create search results (arf+)
<li> Ability to specify searchable fields
<li> Display either recent searches (by saving user input when they select a result) or default searches (similar to in <a href="https://github.com/cheniel/alfred-tea-master">Alfred Tea Master Workflow</a>) before user inputs a query
<li> Ability to add interactively add data from Alfred interface (static only)
<li> LaTeX Guide
<li> Web form that allows for easy creation of "data.arf" files for static usage.
<li> Mod to a Flashcard Framework
</ul>
