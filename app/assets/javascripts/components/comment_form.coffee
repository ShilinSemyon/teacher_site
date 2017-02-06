@CommentForm = React.createClass
  getInitialState: ->
    body: ''
    post_id: @props.post_id
    user_id: @props.user_id
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  handleFocus: (e) ->

  valid: ->
    @state.body
  handleSubmit: (e) ->
    e.preventDefault()
    $.post "/posts/#{@props.post_id}/comments", { comment: @state }, (data) =>
      @props.handleNewComment data
      @setState @getInitialState()
      'json'
  render: ->
    if @state.user_id is null
      React.DOM.div
        className: 'alert alert-info'
        'Чтобы оставить свой комментарий, пожалуйста, '
        React.createElement('a', { href: '/profile/register', style: {textDecoration: 'underline'} }, 'зарегистрируйтесь!')
    else
      React.DOM.form
        id: 'commentform'
        className: 'comment-form'
        onSubmit: @handleSubmit
        React.DOM.div
          className: 'form-group comment_body'
          React.DOM.textarea
            type: 'text'
            id: 'comment_body'
            className: 'form-control'
            label: 'Комментарий'
            placeholder: 'Комментарий'
            name: 'body'
            value: @state.body
            onChange: @handleChange
        React.DOM.div
          className: 'form-group comment_post_id'
          React.DOM.input
            id: 'comment_post_id'
            type: 'hidden'
            className: 'form-control'
            name: 'post_id'
            value: @state.post_id
        React.DOM.div
          className: 'form-group comment_user_id'
          React.DOM.input
            id: 'comment_user_id'
            type: 'hidden'
            className: 'form-control'
            name: 'user_id'
            value: @state.user_id
        React.DOM.button
          type: 'submit'
          className: 'btn btn-primary'
          disabled: !@valid()
          'Отправить'
