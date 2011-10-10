<%@ include file="header.jsp" %>


<h1>Register</h1>

<form:form commandName="user" method="POST" name="user">


<div>
<label for="username">Username:</label>
<form:input path="username" id="username"/><br>
<form:errors path="username" cssClass="formErrors"/>
</div>

<div>
<label for="firstname">First Name:</label>
<form:input path="firstName" id="firstname"/>
<form:errors path="firstName" cssClass="formErrors"/>
</div>

<div>
<label for="lastname">Last Name:</label>
<form:input path="lastName" id="lastname"/>
<form:errors path="lastName" cssClass="formErrors"/>
</div>

<div>
<label for="lastname">Institution:</label>
<form:input path="institution" id="institution"/>
<form:errors path="institution" cssClass="formErrors"/>
</div>

<div>
<label for="password">Password:</label>
<form:input path="password" id="password"/>
<form:errors path="password" cssClass="formErrors"/>
</div>

<div>
<label for="email">Email:</label>
<form:input path="email" id="email"/>
<form:errors path="email" cssClass="formErrors"/>
</div>

<div>
<label> &nbsp;</label>
<div class="formButton"><input type="submit" value="Register"/></div>
</div>

</fieldset>

</form:form>


<%@ include file="footer.jsp" %>