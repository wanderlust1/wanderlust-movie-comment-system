create trigger [dbo].[decrease_comment_count] on [dbo].[comment] for delete as
update movie_detail set rateCount = rateCount - 1
from movie_detail, deleted
where movie_detail.movieId = deleted.movie_id

Go

create trigger [dbo].[increase_comment_count] on [dbo].[comment] for insert as
update movie_detail set rateCount = rateCount + 1
from movie_detail, inserted 
where movie_detail.movieId = inserted.movie_id

Go

create trigger [dbo].[decrease_vote] on [dbo].[comment_like]
for delete as
update comment set comment.vote = comment.vote - 1
from comment, deleted
where comment.comment_id = deleted.comment_id

Go

create trigger [dbo].[increase_vote] on [dbo].[comment_like]
for insert as
update comment set comment.vote = comment.vote + 1
from comment, inserted
where comment.comment_id = inserted.comment_id
