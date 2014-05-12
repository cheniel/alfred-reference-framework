<img src="https://github.com/cheniel/alfred-reference-framework/raw/master/icon.png" width="100px" height="100px"> Alfred Reference Framework
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

## Installation


## Creating an ARF workflow

There are two ways to create an ARF workflow: static and dynamic. 

Static is best if you have data which does not change. This mode requires no coding and is just a matter of populating a !-delimited text file. The user's input searches over the names of the data. 

Dynamic is best if you have data that changes over time (for example, tweets containing a certain hashtag), from computer to computer, or any other variable. It requires using the ARF+ library and you have to create your own method for determining what results to display (as opposed to the simple name-search offered in static mode).

After you've installed ARF and picked which mode you want to use, go to the workflow's entry in the Alfred Preferences and double-click on the script filter module. 

If you've picked static mode, make sure the first line of the script portion of the script module is:
> ./arf/main.sh arf/data/static.arf {query} --static

If you've picked dynamic mode, make sure the first line of the script portion of the script module is:
> ./arf/main.sh arf/data/static.arf {query}

Both dynamic and static mode have pre-filled examples for you to take a look at.

### Static Mode
To create an ARF workflow in static mode, all that is required is modification of <a href="https://github.com/cheniel/alfred-reference-framework/blob/master/arf/data/static.arf">static.arf</a>, which is a '!' delimited plain text file in the "data" folder containing the data searched and displayed. 

Here's an example of what the data looks like for the results shown in the <a href="https://github.com/cheniel/alfred-reference-framework#how-it-works">example in this README</a>:

> Sun!1.9891 × 10^30 kilograms!N/A						
> Mercury!0.330 x 10^24 kilograms!1    
> Venus!4.87 x 10^24!2   
> Earth!5.97 x 10^24 kilograms!3 	  
> ...

That is the input for the data. Each line corresponds to one potential result, you can have them as anything you'd like, with any number of fields (determined by "!" separation), although there are some characters that you should avoid which are documented in the comments of <a href="https://github.com/cheniel/alfred-reference-framework/blob/master/arf/data/static.arf">static.arf</a>. ARF will automatically search over the first field for you (in this case Sun, Mercury, Venus...) to give the results back to the user. When a result is selected, the rest of the information in the line of that result will be displayed. See the example <a href="https://github.com/cheniel/alfred-reference-framework#how-it-works">above</a> for clarification.

There are five other things you need to define as well, which are and must be the first five lines of the file. These are the "preference lines". 
> Planet Name!Mass!Order From Sun    		  
> arf/img/f1/default.png!arf/img/f2/default.png!arf/img/f3/default.png  
> no!no!no  
> no!no!no  
> !!! 

Each line has and must have the same number of "!" as the data. Each field in the preferences correspond to the same field in the data. So, for example, the preferences "Planet Name," "arf/img/f1/default.png," "no," "no," and "" all apply to Sun. 

If you are just looking to make a very basic workflow to look up data, you probably only need to modify the first two lines, and the other three should remain the same. Here's what the preference lines are:
<ol>
<li> The first line contains the field names which correspond to the data types. This is displayed when a result is selected in the subtext.
<li> The second line defines the default image displayed for that result. An easy starting point is "icon.png" if you don't have images yet.
<li> The third line defines the "valid" attribute. This determines whether the "autocomplete" or "argument" attribute is used when the result is selected.
<li> The fourth line defines the "autocomplete" attribute, only used when valid is no. When the result is selected, the autocomplete attribute replaces the user query. In ARF, an autocomplete attribute of "no" simply does nothing when the result is selected.
<li> The fifth line defines the "argument" attribute, only used when valid is yes. This passes a query to action.sh, which requires some coding. You could use this to open a webpage, run a script, or do a variety of other things.
</ol>

<a href="http://www.alfredforum.com/topic/5-generating-feedback-in-workflows/">Official documentation on the attributes defined in the last three lines.</a>

That's pretty much all you need. For more explanation on how to make a ARF workflow in static mode, take a look at <a href="https://github.com/cheniel/alfred-reference-framework/blob/master/arf/data/static.arf">static.arf</a>, which is commented with instructions. 

Make sure that you remove all non-data and non-preference lines (including empty lines and comment lines) before production, as it slows down your search.

### Dynamic Mode
To create a dynamic ARF workflow, you have to modify the <a href="https://github.com/cheniel/alfred-reference-framework/blob/master/arf/dynamic.sh">dynamic.sh</a> file using the arf+ library. The arf+ library contains methods that you call from within <a href="https://github.com/cheniel/alfred-reference-framework/blob/master/arf/dynamic.sh">dynamic.sh</a>.

##### Setting preferences
The first thing you must do is set the preferences. At the minimum, this takes 2 method calls, but if you want to customize all the preferences it takes 6. Here is what setting preferences looks like:
> setFieldNames "Name" "Birthday" "Gender"  
> ...add optional preference methods here...  
> establishPreferences  

The first and third methods in the snippet are the two required calls. setFieldNames corresponds to filling out the first preference line in the .arf file. It also establishes the number of fields as well as initializing the rest of the lines to default values. establishPreferences uses all of the preference method calls to create a temporary .arf file in the user's volatile data folder. You can make the preferences specific to the user's query, however you should never begin adding data until establishPreferences is called.

The optional preference methods correspond to the other four preference lines. They must be called after setFieldNames and before establishPreferences. Here are the methods:
> setIcons "icon.png" "icon.png" "icon.png"   
> setValidity "no" "no" "no"	
> setAutocomplete "no" "no" "no"	
> setArguments "" "" ""	  

Each of these calls should have the same number of arguments as setFieldNames. The specific snippet shown above doesn't actually do anything, as the method calls in the snippet all pass in the default values which have already been set by setFieldNames (e.g. default icons are "icon.png" for all fields, validity is "no", etc.). <a href="http://www.alfredforum.com/topic/5-generating-feedback-in-workflows/">Read about the attribute types here.</a>

##### Adding data
After establishing preferences, you can begin adding data based on the user's query. For your convenience, the user's query is stored in a variable. Here is an example from <a href="https://github.com/cheniel/alfred-reference-framework/blob/master/arf/dynamic.sh">dynamic.sh</a> which responds to the user's query "cah".

> if [ "$userInput" == "cah" ]; then  
>     addData "$userInput" "Calvin" "November 18, 1985" "Male"    
>     addData "$userInput" "Hobbes" "November 18, 1985" "Male"    
>     addData "$userInput" "Bill" "July 5, 1958" "Male"     
> fi  

After finding that the user's query is "cah", the script adds three results using the arf+ method addData. To use add data, you must call the method with the number of arguments that were passed into setFieldNames plus one. The first argument is always just "$userInput", and the other arguments all correspond to the data in the fields. This code snippet produces an Alfred result as below:



Check out <a href="https://github.com/cheniel/alfred-reference-framework/blob/master/arf/dynamic.sh">dynamic.sh</a> for another example.

The very last method call in every <a href="https://github.com/cheniel/alfred-reference-framework/blob/master/arf/dynamic.sh">dynamic.sh</a> should be the ARF+ method pushData.

##### Setting a custom error message
If the user inputs a query that produces no results, 

### Images
For adding default images for results

### Interactivity


## Development

Actively under development, currently functional on static mode. v1.0 will be when arf+ is finished. ARF+ is a library that will allow for the dynamic generation of results that can be searched and displayed. This will allow dynamic information to be retrieved from the web and other sources. Please feel free to contribute.

###Future Additions / Potential Pull Requests
<ul>
<li> Ability to specify searchable fields 
<li> ARF+ method which enables searching static as well as dynamic data in dynamic mode.
<li> Display either recent searches (by saving user input when they select a result) or default searches (similar to in <a href="https://github.com/cheniel/alfred-tea-master">Alfred Tea Master Workflow</a>) before user inputs a query
<li> Ability to add interactively add data from Alfred interface (static only)
</ul>

### Acknowledgements

## Examples
<ul>
<li> <a href="https://github.com/cheniel/alfred-tea-master">Alfred Tea Master Workflow</a>
</ul>
Let me know if you use it to make a workflow and I'll put it here.
