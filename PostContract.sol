// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract PostContract {
    // Struct to store post details
    struct Post {
        address author; // Address of the post creator
        string title;   // Title of the post
        string content; // Content of the post
        uint256 timestamp; // When the post was created
    }

    // Array to store all posts
    Post[] private posts;

    // Mapping to store posts by address
    mapping(address => Post[]) private postsByAuthor;

    // Event to notify when a new post is created
    event PostCreated(address indexed author, string title, uint256 timestamp);

    /// @notice Creates a new post
    /// @param _title The title of the post
    /// @param _content The content of the post
    function createPost(string memory _title, string memory _content) public {
        require(bytes(_title).length > 0, "Title cannot be empty");
        require(bytes(_content).length > 0, "Content cannot be empty");

        // Create a new post
        Post memory newPost = Post({
            author: msg.sender,
            title: _title,
            content: _content,
            timestamp: block.timestamp
        });

        // Add the post to the main array and the author's mapping
        posts.push(newPost);
        postsByAuthor[msg.sender].push(newPost);

        // Emit an event for transparency
        emit PostCreated(msg.sender, _title, block.timestamp);
    }

    /// @notice Retrieves all posts
    /// @return An array of all posts
    function getAllPosts() public view returns (Post[] memory) {
        return posts;
    }

    /// @notice Retrieves all posts by a specific author
    /// @param _author The address of the author
    /// @return An array of posts created by the given author
    function getPostsByAuthor(address _author) public view returns (Post[] memory) {
        return postsByAuthor[_author];
    }
}
