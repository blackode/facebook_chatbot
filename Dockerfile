#Build Stage
FROM bitwalker/alpine-elixir:latest AS release_stage

#Copy the source folder into the Docker image
COPY . .

#Install dependencies and build Release
RUN export MIX_ENV=prod && \
    rm -Rf _build && \
    mix local.rebar --force && \
    mix deps.get && \
    mix release digi_coin

#Deployment Stage
FROM bitwalker/alpine-elixir:latest AS run_stage

#Set environment variables and expose port
EXPOSE 4000
ENV REPLACE_OS_VARS=true \
    PORT=4000

COPY --from=release_stage $HOME/releases .
RUN chown -R default: ./bin

#Change user
USER default

#Set default entrypoint and command
CMD ["./bin/digi_coin", "start"]
