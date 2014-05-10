Alfred Reference Framework
==========================

Framework for Alfred written in Bash which makes it easy to create workflows to search and look up information without leaving the Alfred interface. This gets around the issue caused by the fact that <a href="http://www.alfredforum.com/topic/5-generating-feedback-in-workflows/">"Script Filters are the only way to pass feedback to Alfred"</a>. 

## How it works:

<ol>

<li> As with all Alfred Workflows, the user begins by typing in workflow's keyword, in this case, "arf"<br>
<img src="http://www.danieljchen.com/images/project/arf/keyword.png">

<li>The user then types in his/her query, and results are displayed. Again, part of the standard Alfred Workflow.<br>
<img src="http://www.danieljchen.com/images/project/arf/search.png"><br>

Normally at this point, the user will select a result and something <b>outside of Alfred</b> will occur, whether that's bring up a webpage, open/do something in a third-party application, etc. The limitations of the Alfred interface mean that once results for a query are displayed, selection of the results means Alfred is done.<p>

<li>With the Alfred Reference Framework, however, this is not the case. Selection of one of the search results generates a special query which then displays results <b>without having to leave Alfred.</b><br>

<img src="http://www.danieljchen.com/images/project/arf/display.png">

</ol>

Another example of a static ARF workflow is the <a href="https://github.com/cheniel/alfred-tea-master">Alfred Tea Master Workflow</a>, which is the code generalized to make ARF. 

## Creating an ARF workflow

There are two ways to create an ARF workflow: static and dynamic. 

Static is best if you have data which does not change. This mode requires no coding and is just a matter of populating a !-delimited text file. The user's input searches over the names of the data. 

Dynamic is best if you have data that changes over time (for example, tweets containing a certain hashtag), from computer to computer, or any other variable. It requires using the ARF+ library and you have to create your own method for determining what results to display (as opposed to the simple name-search offered in static mode).

### Static Mode
Creating a basic ARF workflow is as simple as modifying a text file. To create an ARF workflow in static mode, all that is required is modification of <a href="https://github.com/cheniel/alfred-reference-framework/blob/master/arf/data/static.arf">static.arf</a>, which is a '!' delimited plain text file containing the data searched and displayed. Check out <a href="https://github.com/cheniel/alfred-reference-framework/blob/master/arf/data/static.arf">static.arf</a> right now to see details on how this is done.

### Dynamic Mode
To create a dynamic ARF workflow, you have to modify the dynamic.sh file using the arf+ library.


### Images
For adding default images for results

### Interactivity



## Development

Actively under development, currently functional on static mode. v1.0 will be when arf+ is finished. ARF+ is a library that will allow for the dynamic generation of results that can be searched and displayed. This will allow dynamic information to be retrieved from the web and other sources. Please feel free to contribute.

###Future Additions / Potential Pull Requests
<ul>
<li> Ability to specify searchable fields 
<li> Display either recent searches (by saving user input when they select a result) or default searches (similar to in <a href="https://github.com/cheniel/alfred-tea-master">Alfred Tea Master Workflow</a>) before user inputs a query
<li> Ability to add interactively add data from Alfred interface (static only)
<li> LaTeX Guide
<li> Web form that allows for easy creation of "data.arf" files for static usage.
<li> Mod to a Flashcard Framework
</ul>

## Examples
<ul>
<li> <a href="https://github.com/cheniel/alfred-tea-master">Alfred Tea Master Workflow</a>
</ul>
Let me know if you use it to make a workflow and I'll put it here.
