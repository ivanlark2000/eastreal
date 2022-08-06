"""add FK id_rel

Revision ID: df9830c17118
Revises: a04ddc05809b
Create Date: 2022-08-06 12:22:22.229190

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'df9830c17118'
down_revision = 'a04ddc05809b'
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('active_flat', sa.Column('id_rel', sa.Integer(), nullable=False))
    op.create_foreign_key(None, 'active_flat', 'relations', ['id_rel'], ['id'])
    op.drop_column('active_flat', 'id_in_site')
    op.drop_column('active_flat', 'number_author')
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('active_flat', sa.Column('number_author', sa.INTEGER(), autoincrement=False, nullable=True))
    op.add_column('active_flat', sa.Column('id_in_site', sa.INTEGER(), autoincrement=False, nullable=True))
    op.drop_constraint(None, 'active_flat', type_='foreignkey')
    op.drop_column('active_flat', 'id_rel')
    # ### end Alembic commands ###
