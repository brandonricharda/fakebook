# README

This is my solution to The Odin Project's final Ruby on Rails assignment. The objective was to create an application that mimics some of Facebook's functionality, including:

- Signing up with a first name, last name, email address, and password
- Signing in with those same credentials
- Sending, receiving, confirming, and denying friend requests
- Creating posts
- Adding comments on posts
- Adding likes to posts

To learn more about the assignment, click here:

https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-on-rails/lessons/final-project

**To play with a deployed version of the app, click here:**

https://tranquil-headland-27361.herokuapp.com/

What follows is a walkthrough of my application and how I've implemented the above functionality.

<h2>Login Page</h2>

<a href="https://imgur.com/dQQZe2e"><img src="https://i.imgur.com/dQQZe2e.png" title="source: imgur.com" /></a>

With the help of a Devise-generated form_for, this page lets users log in if they have existing credentials. If you'd like to follow along in the deployed app, use these credentials:

- **Email:** brandon@gmail.com
- **Password:** Brandon123 _(case sensitive)_

If you use the above credentials, you'll be able to test the friendship-related functions as I've seeded a few friends and posts in the database. If you create a completely new account, you'll be able to send friend requests to the seeded users but they obviously won't repond.

If you'd like to create a new account nonetheless, click **Sign up.**

**Note:** Password recovery link has been eliminated since that function is useless without the mailer activated anyway (I disabled it because my SendGrid account was suspended – currently in the process of getting it back).

<h2>Signup Page</h2>

<a href="https://imgur.com/P1YKUxd"><img src="https://i.imgur.com/P1YKUxd.png" title="source: imgur.com" /></a>

With the help of another Devise-generated form_for, this page is where you can register for a new account. I modified the form so you can also add a **Profile picture** if you'd like.

<h2>Homepage (once signed in)</h2>

<a href="https://imgur.com/XQeEe4L"><img src="https://i.imgur.com/XQeEe4L.png" title="source: imgur.com" /></a>

This page mimics the functionality of Facebook's main timeline page. If you used my pre-created credentials, you'll see posts from the auto-generated users (five of whom are brandon@gmail.com's friends).

At the top center of the page (under the navbar), you'll see you can **Create a new post.**

Underneath that form, you'll see the **Latest posts** section. By default, each post has two options:

- **Add Like** which mimics Facebook's like functionality. If you click it, a new record will be created in the Likes table corresponding with your user. The page then reloads and when this post you've just liked reappears, logic looks in your user's **Likes** to see if the post is already among them. If it is, the **Add Like** button is replaced with a **Remove Like** button. You'll also see a **People who liked this post** section appear with your (clickable) name in it. If you click the **Remove Like** button, the corresponding record in the Likes table will be destroyed.
- **Submit Comment** which is the submit button for a form that does exactly what you'd assume. When you leave a comment, it will appear under your (clickable) name. When the page reloads, logic will also look to see if that comment is in your user's **Comments.** If it is, a "Remove Comment" button will appear and delete that record if you click on it.

At the top left of the homepage, you'll also see your logged in user's basic profile information (email + member since).

At the top right of the homepage, you'll see any **Pending requests** you've received from users. There aren't any by default.

<h2>Profile Page</h2>

<a href="https://imgur.com/M1lSxBk"><img src="https://i.imgur.com/M1lSxBk.png" title="source: imgur.com" /></a>

Here, you'll see your logged in user's basic profile information (top left) and **Latest posts** in the center. The timeline containing your user's posts behaves virtually identically (save for the posts it pulls from) to the homepage's timeline section. In fact, these are generated using the same partial (which simply accepts posts – it doesn't care from whom – as an argument and generates the timeline view for them).

<h2>Edit Your Profile Page</h2>

<a href="https://imgur.com/Q10ciOr"><img src="https://i.imgur.com/Q10ciOr.png" title="source: imgur.com" /></a>

This Devise-generated form lets you update or delete your user. I added functionality that lets you add a profile image here if you'd like.

<h2>Users Page</h2>

<a href="https://imgur.com/M15uHOA"><img src="https://i.imgur.com/M15uHOA.png" title="source: imgur.com" /></a>

Here's where you can see all users on the platform and your relationship to them. **Friends**, **Pending Friend Requests** (sent and received), and **Strangers** will all appear in their own sections.

If a user is your friend, you can click the **Unfriend** button under their name, which will delete that **Friend Request** record (there is no "friendship" model – only confirmed **Friend Requests**).

If a user is not your friend and no **Friend Request** record exists between you two, you'll see the option to **Send Friend Request.** When the page reloads, this **Friend Request** you sent will appear in the **Pending Friend Requests You Sent** section, at which point you also have the option to cancel the request.

<h2>Models Used in This Project</h2>

Lastly, here's a quick walkthrough of the models I used for this project.

- **User:** This was mostly Devise-generated but I added quite a few helper methods to the model (i.e. methods that make database calls to find things like the user in question's **Friends** and **Pending Received Requests**).
- **Post:** User has_many of these (and they all belong_to the user)
- **Comment:** User has many of these (and they all belong_to both the user and associated post)
- **Like:** User has many of these (and they all belong_to both the user and associated post)
- **Friend Request:** User has many received_requests and sent_requests, both of which connect with this table

<h2>Future Upgrades</h2>

While I'm happy enough with my app to call it a day and proceed with the remainder of The Odin Project's curriculum, there are some things I'd like to revisit down the line, including:

- **Design:** There's no denying the application's visual design leaves much to be desired. I merely wanted to get it to a point where it could show off the backend's functionality. I'll revisit the design once I learn more about CSS (which is the next chapter in The Odin Project)
- **Welcome Email Functionality:** I actually set this up using the letter_opener gem in development. When I deployed the app and attempted to send emails with SendGrid, the service suspended my account. I've submitted an email to get it back. For now, I've commented those lines out in my application.
- **Facebook Login Functionality:** This is another feature I implemented in development. However, after deploying the app, I noticed I couldn't activate this feature without switching my Facebook app out of development mode, which required a Privacy Policy. Given this is a test app, no such policy exists and so I disabled that feature for now. At some point I may revisit and reactivate it, though.

<h2>Reflection</h2>

This project was **a lot** of fun. The model structures came very naturally to me. While there were certainly frustrating errors that popped up along the way, the skills I developed over the course of previous Odin Project assignments helped me confidently address them. I'm very happy with how it turned out and while I know there are still many things to learn, I feel more than confident enough to build my own world-ready Rails apps.
