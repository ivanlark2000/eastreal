"""flats

Revision ID: b0e122aff103
Revises: 
Create Date: 2022-07-24 15:29:48.127742

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'b0e122aff103'
down_revision = None
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.create_table(
        'flat',
        sa.Column('id', sa.Integer, primary_key=True),
        sa.Column('id_avito', sa.Integer),
        sa.Column('number', sa.Integer),
        sa.Column('price', sa.Numeric(15, 2), nullable=False),
        sa.Column('qty_of_rooms', sa.Integer),
        sa.Column('total_space', sa.Numeric(3, 2), nullable=False),
        sa.Column('square_of_kitchen', sa.Numeric(3, 2), nullable=False),
        sa.Column('living_space', sa.Numeric(3, 2), nullable=False),
        sa.Column('floor', sa.Integer, nullable=False),
        sa.Column('furniture', sa.String(200)),
        sa.Column('technics', sa.String(200)),
        sa.Column('balcony_or_loggia', sa.Boolean, nullable=False),
        sa.olumn('room_type', sa.String(120)),
        sa.Column('ceiling_height', sa.Numeric(3, 2)),
        sa.Column('bathroom', sa.String(120)),
        sa.olumn('widow', sa.String(120)),
        sa.Column('repair', sa.String(120)),
        sa.Column('seilling_method', sa.String(120)),
        sa.Column('transaction_type', sa.String(120)),
        sa.Column('decorating', sa.String(120)),
        sa.Column('district_id', sa.Integer, ForeignKey('district.id'), nullable=False),
        sa.Column('house_id', sa.Integer, ForeignKey('house.id'), nullable=False)
        )


def downgrade() -> None:
    op.drop_table('flat')
