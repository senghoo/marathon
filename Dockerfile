FROM rails:onbuild
RUN rake assets:precompile
